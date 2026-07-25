Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DC34E763
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007654; cv=none; b=hHpTRokBVc5c4YhmW6verADqzIAocQvUQAeUTPHMgwvmaHwwzZLM2EzJ/C+RvuAAg144R/9bewqUO4VE18kkezDB8evUv5JMj3wERJX9VfkOnxqj5rmfnHeucFIXuutUSWqfblEC75mdpjdem0yCTr7tpQL2vK5QuGSLgrxqt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007654; c=relaxed/simple;
	bh=bsuecbN3827QXbzL8fBavHd+aK6XVpK3d3VXnu3QuzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iMuA8YEUQ/6zJ+3vEjf7TPnUaT2A/QJ0szpzqpJShZl8V+q5WPtTf49IHM9jjKFEXQTbpX3PvXGWkn/85ykEQLmLWrsaDVYcy5F1YIt1UVxlYWY32/xuFv54SaON/lMsguvy7jpLtzMBCZbw4immfjjyOuYqfWugf29S/Qzw+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke/ROIer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke/ROIer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9971F000E9;
	Sat, 25 Jul 2026 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785007653;
	bh=i5Z1QNTJq67R0RYsP5PYyclIm8fOLpgUfnGWsjgDPkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ke/ROIer9YQ9IeIfwWbBgg4r5wz5VnC4xH4O1lpScaxG9WI1Ml1aF8Vls9eTij0FF
	 wKIn1H8VGyPQjQ8pG7qgucumPSeYzyt+XIyzz1YCi2qDrfVXGVcQdVvEW4BD9rpGc4
	 aUDJkXDnxHhm5XNGuPV72oLph17QrQmOXzbV8NverULaiZzx6f42HVGveYW/qJsCmq
	 Yl3ovOENyXvFlhRnYBPnoX02OUao7/AzPq1b4GubfURc+o+Ge87z3LMEQn+E1emhr6
	 gjswLQX06dl5EW27rVYVDLJ76e3IMWfpE0S1mLWEMXDlqAFK45mRf+8vbQajEEHWNm
	 foIwybLpIkOhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] perf trace-event: Fix buffer overflow in
 read_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725184953.234759-2-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
 <20260725184953.234759-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 19:27:32 +0000
Message-Id: <20260725192732.CA9971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer dereference of session->tevent.pevent on malforme=
d perf.data due to error check bypass.
- [High] Implicit truncation of 64-bit sizes to 32-bit signed integers in `=
do_read` and `skip`, and integer overflows in allocations, lead to stack/he=
ap buffer overflows and uninitialized memory disclosures.
--

--- Patch [1]: [PATCH v4 1/5] perf trace-event: Fix buffer overflow in read=
_string() ---
commit b0a22e84b8d80d3f8d078756fde29ba8352194d0
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix buffer overflow in read_string()

This commit fixes a stack buffer overflow in read_string() by adding a boun=
ds
check before writing each character into the buffer. If the string from the
input is longer than BUFSIZ, it now prevents the overflow and returns NULL,
matching other error paths.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index ecbbb93f01853..afd458cf1387d 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -127,6 +127,11 @@ static char *read_string(void)
>  			}
>  		}
> =20
> +		if (size >=3D (int)sizeof(buf) - 1) {
> +			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
> +			goto out;
> +		}
> +
>  		buf[size++] =3D c;
> =20
>  		if (!c)

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing buffer
overflows in this file, are there similar truncation issues in do_read() and
skip()?

Looking at do_read() and skip() in tools/perf/util/trace-event-read.c, they
take size as a signed int:

static int do_read(void *data, int size)
static void skip(int size)

When a large 32-bit or 64-bit size is read from the trace data and passed to
these functions, it can be truncated to a negative integer. In skip(), could
this negative value cause the computed read amount to become negative,
triggering do_read() and eventually the read() system call to attempt readi=
ng a
massive amount of data into the local stack buffer?

Similarly, in read_ftrace_printk() and read_saved_cmdline(), can the
malloc(size + 1) calculation overflow to 0 when a large size is provided,
creating a tiny allocation before do_read() is called with the truncated
negative size, leading to a heap overflow?

[Severity: High]
This is a pre-existing issue, but can a malformed perf.data file cause a
dangling pointer dereference during error handling?

In tools/perf/util/header.c:perf_event__process_tracing_data(), if
trace_report() returns an error (-1), size_read becomes -1. The subsequent
padding calculation:

	padding =3D PERF_ALIGN(-1, 8) - (-1);

evaluates to 1. This means size_read + padding equals 0. If the provided ev=
ent
size is 0, the size mismatch check:

	if (size_read + padding !=3D size)

evaluates to 0 !=3D 0, which is false, bypassing the error check.

Since trace_report() triggers trace_event__cleanup() on error paths, which
frees t->pevent without setting it to NULL:

tools/perf/util/trace-event.c:trace_event__cleanup() {
	tep_unload_plugins(t->plugin_list, t->pevent);
	tep_free(t->pevent);
}

Does this bypass lead to evlist__prepare_tracepoint_events() being called w=
ith
a dangling session->tevent.pevent pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725184953.2347=
59-1-tshah@linux.ibm.com?part=3D1
