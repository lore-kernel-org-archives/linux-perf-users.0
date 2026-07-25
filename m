Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B62F7EEE
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964148; cv=none; b=EA3UtIEAHSHJdqvgYYDsKDk5MPQSO15KO+4ET7DUWxyla+xzNV4/quZCOOYmKf6cEMNMcNFG94oP8fI3+kmo9JS9OLOe8Rmq+OnK1LgxwrD6O8XbXEi+nSBZrp9OQUJpOV1J9l7+orLYTLq83w9URNx/lnqDdlD7LhI9c98EbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964148; c=relaxed/simple;
	bh=9CBmTqID3viU01vCso5RlxG35P/hIkB13NOWIvIbea0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLW3bO7JMO/+IiJYWr5Ri0j//P79bFZ6vxRD2AoxJZSJlJYNu2HFPtpV5wHeCKbb8v8WcCF3/tZH/bz+W52zMX+kJUk3V29AxkHRyv/loGxT6PSwdxZXi6rIWM8D3WFotuhy2d54HhLdQDSffFlh4xqnkLfTqqHWF6095r3Q4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv1hMAQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv1hMAQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E471F000E9;
	Sat, 25 Jul 2026 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964146;
	bh=I7RbKlL5G/TiNHS+6nNBti+OKtAaBNcTSKPu2QzSL2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nv1hMAQrbxB27mfuL0y8SK15notukgTfQN/TV0ODrje4ruL87bEaTonyZhhDohWRQ
	 wSv4MnF95WN3P1ERqE0GuTCjMwqpVUY7YtrjCV2vwwVOCQsIsB4OTI61vxUvm5SDK3
	 81MSN6JaYsEoFRtrcqd/vWdFSz5u6q5Xd1/gFZL5MET3tc0hZXVJ1T6jmm0vPNiCyD
	 QIwJzESt/FKAV6Ydjyhyarxv4nOz6b/zNYYk20FNWsRCHN6sJUMtun7a6l64G2K9zx
	 EqMAnEApLsbf8pHpSxmD3j6C1k/MAewfvOajBQc6CaERbs+lPxbb1LsMC/cLlFwUiN
	 J9D950hHcQ4yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 6/6] tools/perf: Add perf tool support for processing
 powerpc HTM AUXTRACE records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725070747.81435-7-atrajeev@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:22:25 +0000
Message-Id: <20260725072226.70E471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The implementation is missing the HTM_MAX_SAFE_TARGETS (1024) ca=
p for num_events that was explicitly promised in the commit message.
- [Medium] htm_config_for_cpu conflates a lookup failure with a valid 0 PMU=
 configuration, causing valid auxtrace events to be dropped.
- [Low] Assigning write() return value to a size_t variable masks the actua=
l error code and produces misleading log messages.
- [Low] Missing explicit inclusion of POSIX standard headers required for m=
usl libc compatibility.
--

--- Patch [6]: [PATCH V3 6/6] tools/perf: Add perf tool support for process=
ing powerpc HTM AUXTRACE records ---
commit b319ae58a675d493de8d8d9853fc6d781771f6b8
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE recor=
ds

powerpc_htm_process_auxtrace_info() reads the (cpu, attr.config) pairs
stored by htm_info_fill() at record time and builds a cpu_configs[]
table.  This lets process_auxtrace_event() map each AUX buffer, which
carries event->auxtrace.cpu, to the correct (node, chip, core) target
and write the raw trace data to htm.bin.nX.pX.cX immediately.

[ ... ]
> - Cap num_events at HTM_MAX_SAFE_TARGETS (1024) to prevent size_t
> truncation on 32-bit platforms when passed to calloc().

[Severity: Medium]
This isn't a bug, but the commit message mentions capping num_events at 1024
(HTM_MAX_SAFE_TARGETS).

Looking at powerpc_htm_process_auxtrace_info(), the arrays are allocated
using num_events directly:

tools/perf/util/powerpc-htm.c:powerpc_htm_process_auxtrace_info() {
    ...
    htm->nr_targets   =3D (int)num_events;
    htm->cpu_configs  =3D calloc((size_t)num_events, sizeof(*htm->cpu_confi=
gs));
    ...
}

Has the 1024 maximum cap and truncation prevention logic been omitted here?

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 952ed32997d9a..1d1b4302e2e4a 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -12,9 +12,14 @@
>  #include "util/session.h"
>  #include "color.h"
>  #include "powerpc-htm.h"
> +#include <errno.h>
>  #include "debug.h"
>  #include "sample.h"
> =20
> +#include <linux/unaligned.h>
> +
> +struct perf_session;

[Severity: Low]
Are the standard POSIX headers missing here?

The code uses functions like open(), write(), lseek(), snprintf(), strerror=
(),
calloc(), and free().

Without explicitly including fcntl.h, unistd.h, stdio.h, string.h, and
stdlib.h, could this fail to compile on systems using musl libc due to
relying on implicit header inclusions?

[ ... ]
> +/*
> + * Look up attr.config by the CPU number carried in event->auxtrace.cpu.
> + * Returns 0 if not found.
> + */
> +static u64 htm_config_for_cpu(struct powerpc_htm *htm, int cpu)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < htm->nr_cpu_configs; i++) {
> +		if (htm->cpu_configs[i].cpu =3D=3D cpu)
> +			return htm->cpu_configs[i].config;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Can a valid configuration evaluate to 0?

If the HTM PMU is configured with node=3D0, chip=3D0, core=3D0 and no other=
 flags,
attr.config could legitimately be 0.

If it returns 0, the caller powerpc_htm_process_auxtrace_event() checks:

tools/perf/util/powerpc-htm.c:powerpc_htm_process_auxtrace_event() {
    ...
    ev_config =3D htm_config_for_cpu(htm, (int)event->auxtrace.cpu);
    if (!ev_config) {
        ...
        return 0;
    }
    ...
}

Would this cause valid auxtrace events to be dropped by conflating a lookup
failure with a valid 0 PMU configuration?

[ ... ]
> +static int write_htm(struct powerpc_htm *htm, void *data, size_t size,
> +		     u32 node, u32 chip, u32 core, int mem_maps)
> +{
> +	u32 target_key =3D htm_pack_target(node, chip, core);
> +	char target_file[128];
> +	size_t written;
> +	int flags;
> +	int fd;
[ ... ]
> +		written =3D write(fd, data, payload);
> +		close(fd);
> +
> +		if (written !=3D payload) {
> +			pr_err("Failed to write memory config: expected %zu bytes, wrote %zu\=
n",
> +			       payload, written);
> +			return -EIO;
> +		}
> +
> +		return 0;
> +	}
> +
> +	/* AUX bus-trace path */
> +	snprintf(target_file, sizeof(target_file),
> +		 "htm.bin.n%d.p%d.c%d", node, chip, core);
> +	flags |=3D htm_target_seen(htm->htm_bin_targets,
> +				 &htm->nr_htm_bin_targets,
> +				 htm->nr_targets,
> +				 target_key) ? O_APPEND : O_TRUNC;
> +	fd =3D open(target_file, flags, 0644);
> +	if (fd =3D=3D -1) {
> +		pr_err("Failed to open %s: %s\n", target_file, strerror(errno));
> +		return -errno;
> +	}
> +
> +	written =3D write(fd, data, size);
> +	close(fd);
> +
> +	if (written !=3D size) {
> +		pr_err("Failed to write htm trace data: expected %zu bytes, wrote %zu\=
n",
> +		       size, written);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Does this code assign the signed return value of write() to a size_t variab=
le?

If write() fails and returns -1, it will be assigned to size_t written,
wrapping it to SIZE_MAX.

While the error is still caught by the written !=3D payload and written !=
=3D size
checks, will this result in logging an impossibly large value for bytes wri=
tten
and mask the actual error code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725070747.8143=
5-1-atrajeev@linux.ibm.com?part=3D6
