Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A23F39D3
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545799; cv=none; b=uCaQM1M9MMrWk/zvedgIEUXqxmjmyqn6Q0QmsK68h36dcDGDC6TUeWhopgWvluvltvMHMSIGW2KxPaPDyC4HdYLWr3c1pFT++nVEug1lDMNNdwTshVYOXsi5NemFLFWkpZGurOf+GBMXoroJ7rCepJ1Kzfwiov6Cmby9RTK4dCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545799; c=relaxed/simple;
	bh=SP9pU2GtbAQh3VBmP5WOOtAuqCGkMNI8BS2F0AzKaLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kEr3LpAoYhnCEz1pOucuusbGMzJHoDtVD2DbItaj4mdce4CtyrjJi0TnFd8j7LPX6zdfwszjakD1m4hST7bq90jZAar9o+9LYvK3bFWQ67RKdfA0hhT8Wq/5WmhIjfRZw6Wwl5/U9t+39BBniEOjxVNmq9NFr7F52qwZigp9KL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPwgKdmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPwgKdmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D761F00A3D;
	Mon, 20 Jul 2026 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545797;
	bh=eRJ8gk4jQYByI3H/FwfMxWeBL5byHptSwxiy4DKwU/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPwgKdmDHGS+LT9UL0H+RTQuWitqz1SzdUYaeO1gIzsX+W6KsPB4Qr7x0ZuoFGUQU
	 T3qP7uZns6Y3xLDiCbS/Ix+L4YN5GSgLjlZ+a7Gu0wtmo+vJYOdACoBZkeotDcUhD4
	 ZbTglqkDaBHQquECsAqMun1BbqG+7NHBFkwXOooJdPmZooshiNIQZa5pQQx3rxJWiC
	 89+TAnn5vRUWC89JHUvTUKqQFgpXjWkTjQTe+NU3/gFlXqWJZdZ2pBY1vxChBRb/jd
	 ZEfCNc4bu9BvSWvPJKCB59fhp2jKVHIcb4w7Ev5C+oztRkIyEQ+TEY8vpLcOsDpUnG
	 rsd6OfbHeIk1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 4/6] powerpc/perf: Capture the HTM memory
 configuration as part of perf data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-5-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:09:57 +0000
Message-Id: <20260720110957.C5D761F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The staging buffer `htm_mem_buf` is allocated as `PAGE_SIZE` b=
ut the hypervisor is instructed to write up to `HTM_MEM_BUF_SIZE` (64448 by=
tes) into it, causing a physical memory overflow on 4K page configurations.
- [High] Uninitialized `struct pt_regs regs` allocated on the stack is pass=
ed directly to `perf_event_overflow()`, leading to a kernel stack memory le=
ak.
- [Medium] The memory configuration iterator `mem_start` is not advanced wh=
en `perf_event_overflow` returns a non-zero (throttled) value, causing data=
 duplication.
--

--- Patch [4]: [PATCH V2 4/6] powerpc/perf: Capture the HTM memory configur=
ation as part of perf data ---
commit 5929e601ef9335650c92ad97d9999f8482e8f648
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Capture the HTM memory configuration as part of perf data
   =20
This commit captures HTM system memory configuration during tracing by
retrieving it via a hypercall. The records are emitted as raw perf sample
data after the AUX trace dump completes.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index b4020a6e8f30b..0fda0f552b4e1 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> @@ -173,6 +177,99 @@ static ssize_t htm_return_check(int rc)
>  #define HTM_TRACING_ACTIVE	1
>  #define HTM_TRACING_INACTIVE	0
> =20
> +#define HTM_MEM_MAX_ENTRIES	2013U
> +#define HTM_MEM_BUF_SIZE	(32 + HTM_MEM_MAX_ENTRIES * 32)
> +
> +static int htm_collect_memory_config(struct perf_event *event,
> +				      struct htm_pmu_buf *aux_buf)
> +{
> +	struct perf_sample_data data;
> +	struct perf_raw_record raw;
> +	struct pt_regs regs;
        ^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this leak kernel stack memory to userspace?

The regs struct is allocated on the stack but never zeroed or initialized.
If userspace configures the perf event with PERF_SAMPLE_REGS_INTR or
PERF_SAMPLE_CALLCHAIN, the core perf framework will read these
uninitialized bytes in perf_event_overflow() and write them to the ring
buffer.

Should regs be initialized, for example via perf_fetch_caller_regs(&regs)
or memset(&regs, 0, sizeof(regs))?

> +	u8 *htm_mem_buf =3D aux_buf->htm_mem_buf;
> +	__be64 *num_entries;
> +	u64 next_start;
> +	u64 to_copy;
[ ... ]
> +		memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
> +
> +		perf_sample_data_init(&data, 0, event->hw.last_period);
> +		memset(&raw, 0, sizeof(raw));
> +		raw.frag.data =3D emit_buf;
> +		raw.frag.size =3D to_copy;
> +		perf_sample_save_raw_data(&data, event, &raw);
> +
> +		if (perf_event_overflow(event, &data, &regs)) {
> +			ret =3D 0;
> +			break;
> +		}
                ^^^^^

[Severity: Medium]
If perf_event_overflow() throttles the event and returns a non-zero value,
we break out of the loop before advancing the iterator.

When tracing resumes and htm_collect_memory_config() is called again,
it will start with the stale aux_buf->mem_start value and repeatedly ask
the hypervisor for the same configuration block. Will this emit duplicate
records into the perf stream?

> +
> +		/* Record written: advance next read iterator */
> +		aux_buf->mem_start =3D next_start;
> +		emitted =3D 1;
> +
> +		if (!next_start) {
> +			aux_buf->collect_htm_mem =3D 0;
> +			break;
> +		}
> +	}
[ ... ]
> @@ -568,7 +672,23 @@ static void *htm_setup_aux(struct perf_event *event,=
 void **pages,
>  		return NULL;
>  	}
> =20
> +	buf->htm_mem_buf =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cp=
u));
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^

[Severity: Critical]
Can this corrupt physical memory on systems with 4K pages?

buf->htm_mem_buf is allocated using PAGE_SIZE, which is 4096 bytes if
CONFIG_PPC_4K_PAGES is enabled.

However, in htm_collect_memory_config(), the hypervisor is instructed that
the buffer length is HTM_MEM_BUF_SIZE:

arch/powerpc/perf/htm-perf.c:htm_collect_memory_config() {
...
			rc =3D htm_hcall_wrapper(htmflags, 0, 0, 0,
					       0, H_HTM_OP_DUMP_SYSMEM_CONF,
					       virt_to_phys(aux_buf->htm_mem_buf),
					       HTM_MEM_BUF_SIZE, aux_buf->mem_start);
...
}

Since HTM_MEM_BUF_SIZE is defined as 32 + 2013 * 32 =3D 64448, the hypervis=
or
will assume it can write 64448 bytes, silently overwriting up to ~60KB of
contiguous physical kernel memory past the 4KB allocation.

Should this allocate HTM_MEM_BUF_SIZE bytes instead of PAGE_SIZE?

> +	if (!buf->htm_mem_buf) {
> +		kfree(buf);
> +		return NULL;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D4
