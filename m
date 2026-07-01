Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066E3BADB2
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896096; cv=none; b=N1J3m+ft9BjodI9F/C2adCRcUIBM0vG9eeGWE5v976EFeHR1E9Ihq8ALu9xArydEWvq2HmYaSMRZmiySYUf9XGv0ShhAmCl1G9l1xKxq+tS4gzInLx+14L+ck7PJRZrEvEM6IJbR2zt7p6Y67YJlKuLZDocwQ3+c7IHWyVMKs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896096; c=relaxed/simple;
	bh=cuHDcznxv/hoAeKTgcxelD5GBmTtpPY416NGe6dsnL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LA6pExdEP9Kd5XBKz1XKdDEI1bwOyEuUNc6a6bqA8csq5G507RzdFg7ntnJYgtTXRTiBvNSHClZbyXAz5QdfbrXpHoZpEPLncbI14eRDznIUbVpGwG/NtWW9kFp/V0/xEZY/tZKmHqyn9TS8zua4jwpwejWr9IUkUsdc8I5ZS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI72Di6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI72Di6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECCB1F000E9;
	Wed,  1 Jul 2026 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896095;
	bh=n5yiSAqCddtFVCXQpYOZK9ouKbtXa+FVceJqwGkuJLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XI72Di6oLpDnKQmAo6W4qDYohyan7aY9mkHQ/vi19twRzvmYh/7w7QSOMncTekJ+A
	 i2zEsxcrAeovcYXe/Fe3aCyKFVp7NLDwo0rZIjqSkAI2dRXndWQE1Qunl/iNwRrCD/
	 rnRqJe6iQWSv4sGUTF/1U0etvSmprQ/JJsYznaAhMErkiXXcl2HajwwR9hcXW7xtTc
	 8YY1M1bhNlNLEZdM5YNg7ALplv4Iwv27DBS0/Nu1f9DkiS4OoMTuzQGbF3XE+BD47a
	 QeBJIU+C38ooMSckaVEJtc9o1aGIPVzPA94vvP/xVRyPufyaOiCI58LKjyZ2qJTAPD
	 s32XfbBAhRQrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] tools/perf: Add arch_record__collect_final_data to
 collect additional data before closing the event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-4-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:54:54 +0000
Message-Id: <20260701085454.8ECCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] `record__final_data` implements a defective busy-wait loop that ca=
uses CPU pegging and infinite loops.
- [High] Redundant and potentially harmful calls to `evlist__enable` during=
 the shutdown phase.
- [High] Collection of final architecture-specific data is randomly skipped=
 due to an early loop break race condition.
- [High] Final data collection is completely omitted when tracing child wor=
kloads.
- [Low] Unnecessary full header inclusions in `record.h` violate subsystem =
guidelines.
- [Low] The function name mentioned in the commit message does not match th=
e actual code implementation.
--

commit 4b101c454c9b203ae14e9902eb253bcd6be33523
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add arch_record__collect_final_data to collect additional data =
before closing the event

While collecting samples using "perf record", function
"__cmd_record" checks if monitoring is done. Once recording
is done, event list will be disabled using "evlist__disable".
After this, event fd won't be read and event will be removed.

Before removing the event, if any additional data needs
to be captured/written to perf.data, currently its not
possible. Introduce arch_record__collect_final_data to
collect additional data before closing the event

> Introduce arch_record__collect_final_data to
> collect additional data before closing the event

[Severity: Low]
This isn't a bug, but the commit message mentions introducing
arch_record__collect_final_data, but the function added is actually named
arch_perf_record__need_read.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..a60bc039401a2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2425,6 +2425,34 @@ static unsigned long record__waking(struct record =
*rec)
>  	return waking;
>  }
> =20
> +/*
> + * Weak symbol - architecture can override to indicate if more
> + * data needs to be collected before finishing output.
> + *
> + * Returns: 1 if more data exists, 0 if collection is complete
> + */
> +__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unu=
sed)
> +{
> +	return 0;  /* Default: no arch-specific data to collect */
> +}
> +
> +static void record__final_data(struct record *rec)
> +{
> +	/*
> +	 * Collect any remaining architecture-specific data.
> +	 * The arch code checks if more data exists, and we do the actual
> +	 * reading here since we have access to record__mmap_read_all().
> +	 */
> +	while (arch_perf_record__need_read(rec->evlist)) {
> +		if (record__mmap_read_all(rec, false) < 0)
> +			break;

[Severity: High]
Does this create a busy-wait loop that pegs the CPU? This loop repeatedly c=
alls
record__mmap_read_all() without yielding or polling.

Additionally, record__mmap_read_all() flushes mmap buffers based on the
thread-local variable, so when running on the main thread it only flushes
thread_data[0]. If the data to be consumed resides in a worker thread's buf=
fer,
could this starve the worker thread and cause an infinite loop?

> +		/* Re-enable events for next batch */
> +		evlist__enable(rec->evlist);

[Severity: High]
Is it intentional to re-enable the events here during the shutdown phase?

Since this is called when done is true to drain the final buffers, calling
evlist__enable() instructs the kernel to resume generating normal profiling
samples. Could this continuously feed new samples into the buffers and trap
the tool in an infinite loop while generating massive amounts of ioctls?

> +	}
> +
> +	return;
> +}
> +

[ ... ]

> @@ -2852,6 +2880,7 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>  		 */
>  		if (done && !disabled && !target__none(&opts->target)) {
>  			trigger_off(&auxtrace_snapshot_trigger);
> +			record__final_data(rec);

[Severity: High]
Could the early break condition earlier in the event loop cause this final =
data
collection to be silently bypassed?

If the main thread's mmap buffers contain no new normal events during the
iteration when the done flag is observed:

__cmd_record() {
    ...
    if (hits =3D=3D thread->samples) {
        if (done || draining)
            break;
    ...
}

It breaks out of the loop and skips over this block, randomly missing the
final architecture-specific data.

[Severity: High]
Will this fail to collect final data when tracing child workloads?

The condition !target__none(&opts->target) evaluates to false when a child
workload is specified (e.g., perf record ./my_app). Because record__final_d=
ata()
is placed inside this pre-existing guard, won't it silently omit the data
collection for normal child workloads?

>  			evlist__disable(rec->evlist);
>  			disabled =3D true;
>  		}
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 93627c9a73387..21f51efd36fc7 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -8,6 +8,8 @@
>  #include <linux/stddef.h>
>  #include <linux/perf_event.h>
>  #include "util/target.h"
> +#include "util/evlist.h"
> +#include "util/util.h"

[Severity: Low]
Is it possible to use a forward declaration here instead of full header
inclusions?

Since arch_perf_record__need_read() only references struct evlist by pointe=
r, a
forward declaration like "struct evlist;" would avoid including these heavy
headers, aligning with the perf subsystem guidelines.

> =20
>  struct option;
> =20
> @@ -95,4 +97,6 @@ static inline bool record_opts__no_switch_events(const =
struct record_opts *opts)
>  	return opts->record_switch_events_set && !opts->record_switch_events;
>  }
> =20
> +int arch_perf_record__need_read(struct evlist *evlist);
> +
>  #endif // _PERF_RECORD_H

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D3
