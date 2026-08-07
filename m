Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE128E0
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116012; cv=none; b=XpM/l5gBN7Dm3u3/MophEY86ZU8xgDiSXh9eUlI1BUFN8rUHtaXyvxCxi+tO1BVufXuwKyKHBBSz4+3Bt/eQo5MNsTlVL0lm/xJoav5Iuqh3aRjKhjaNldRdZYTMV2755aRaOjNWBy/ZcFhyWsdNTANC9bHkismV1DUy/B5NdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116012; c=relaxed/simple;
	bh=fUxrvJ7C2G6mMVPc7d4tRP9D5B2OOi/jX+iYA5vtGrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WdVBfdphO83UGcMYvJw/E/KFVSiQA4gSBBT97TGdocDvCBHNmITZilfbClUCBVQtoicVAl2QDXObt87CVshd4j1vAd8GQSNq99ApMi9YfMG1YL3vD0FpnEyvYk6XbTKsW45wgsQDE5u0I3YCFcOmM1rIApGIKh3Wjfmlj8bw6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEz1mETb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEz1mETb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54701F00A3D;
	Fri,  7 Aug 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116010;
	bh=LnQyLrPEBfRDQacK29mtLecWxddNaYjlbRuHjoA3yI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEz1mETbQ9R10Z8n22LviJJNnpnkN673iFC12IJoATlVPQj9byQCFuD6F4FjFnRgV
	 beT57/oB+bkL16wY7q3AaAX8N76E+38ALpYebq3FMbBvtQmshPDnMcTNeAVOEiOmeA
	 gO+Oox1jxxdRCI0OJmtpjxHd7fJGN/9GeG3BMvtpl6XOREIArSFcgQOmUo1T1PykWR
	 5hvIRHzaDfU/Bacu5v4+a+EoRPt96RJNHFj51wVhxEYhc6RC7Nt4W5VGjfMRe9q6Kc
	 A3EAZ/3c8ffcU/lGeBabPTQFzQaBAerQKbcS1WSal0DFe4m3oNnvot1ZTcwUQz2Ugj
	 x8FvXBzLUHieQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 3/6] tools/perf: Add arch hook to drain remaining
 data before event close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807144135.2607-4-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:20:10 +0000
Message-Id: <20260807152010.B54701F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `record__final_aux_data()` drain loop can spin infinitely duri=
ng system-wide or attached-process tracing because it is called before disa=
bling events, allowing the active PMU to continuously generate new data. Fu=
rthermore, if the main loop exits via early break, events are never explici=
tly disabled.
--

--- Patch [3]: [PATCH V5 3/6] tools/perf: Add arch hook to drain remaining =
data before event close ---
commit a89566ddd972102f4f5d6b30845f8dc3daa34fb4
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add arch hook to drain remaining data before event close

This commit introduces a mechanism to drain remaining AUX data before closi=
ng
event file descriptors. It uses a weak architecture hook to check for pendi=
ng
data and retries reading until progress stalls.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..10f73aa2612ca 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -2425,6 +2428,57 @@ static unsigned long record__waking(struct record =
*rec)
>  	return waking;
>  }
> =20
> +/*
> + * Weak arch hook called by record__final_data().
> + * Returns 1 if the arch PMU driver still has records pending (the caller
> + * will call record__mmap_read_all() and retry), 0 when done.
> + * Implementations use perf_evsel__read() so this must be called while
> + * events are still ACTIVE (before evlist__disable()).
> + */
> +__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unu=
sed)
> +{
> +	return 0;
> +}
> +
> +static void record__final_aux_data(struct record *rec)
> +{

[ ... ]

> +		if (record__bytes_written(rec) =3D=3D last_bytes_written) {
> +			if (++retries >=3D FINAL_DATA_MAX_RETRIES) {
> +				pr_warning("Final AUX data drain made no forward progress after %d r=
etries.\n",
> +					   FINAL_DATA_MAX_RETRIES);
> +				break;
> +			}
> +			usleep(1000); /* 1 ms: let AUX ring buffer consumer advance */
> +		} else {
> +			retries =3D 0;
> +			usleep(100);
> +		}
> +	}
> +}

[ ... ]

> @@ -2852,11 +2906,22 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>  		/*
>  		 * When perf is starting the traced process, at the end events
>  		 * die with the process and we wait for that. Thus no need to
>  		 * disable events in this case.
>  		 */
>  		if (done && !disabled && !target__none(&opts->target)) {
>  			trigger_off(&auxtrace_snapshot_trigger);
> +			if (rec->opts.full_auxtrace)
> +				record__final_aux_data(rec);
>  			evlist__disable(rec->evlist);
>  			disabled =3D true;
>  		}
>  	}

[Severity: High]
Could this lead to an infinite loop during system-wide or attached-process
tracing?

Because record__final_aux_data() is called before evlist__disable(), the
events are still active and generating new data.

If the workload is continuously generating data, record__bytes_written()
will constantly increase, resetting the retry counter to 0 in the
record__final_aux_data() loop we see above.

Would it be possible to disable the events first, and then drain the
remaining data?

> +	/*
> +	 * If the loop exited without entering the in-loop disable block
> +	 * (early break, or child workload where target__none is true and
> +	 * the block is never reached), drain any remaining AUX data now.
> +	 * Events are still live at this point.
> +	 */
> +	if ((target__none(&opts->target) || !disabled) && rec->opts.full_auxtra=
ce)
> +		record__final_aux_data(rec);

[Severity: High]
If the main loop exits via an early break and this fallback block is reache=
d,
does this leave the events permanently active?

Since evlist__disable() is never called in this path, we might spin
infinitely in record__final_aux_data() for the same reason mentioned above,
continuously reading newly generated data.

>  	trigger_off(&auxtrace_snapshot_trigger);
>  	trigger_off(&switch_output_trigger);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807144135.2607=
-1-atrajeev@linux.ibm.com?part=3D3
