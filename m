Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C53DD868
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556779; cv=none; b=rhmNTI2y8KlTNFgvP2pQEf7AML3O7CQRS8RBXce4OKV3Oig1wd9tu/sYQGli+K7NHtDbiz47k7X4+UbALoIbCMycfSMOYpWdgh/wa5T8ZnO+vxh8R8Cjoq2t8Im/oDf6Xom/KJXqsmRWT68NMAOkBAIFOk5gF85AkZ2o/7DstB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556779; c=relaxed/simple;
	bh=sBJUi5yqQIVmIlNQllU98uZFUccZ1FQX4M9sLGhnd0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=umH9+Oho2TLeBb1ROhDe9DPtp9axoCHw41f81YMLSmeM8WGOUa7mlSbaQ+ZSZObM0mEviw2bJdr59+D5IIFUaey8EdcgKvnB7lkGdohGa7Iv/7uH/I31jsHoA1z9L26MKCJs7ylDN2hQ8TqKXxYH2hRbgAYQWuy4RewXOmJhC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSxt4MiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSxt4MiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0050E1F00893;
	Thu,  4 Jun 2026 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780556777;
	bh=dfiop4K+LBhcPglFXhEVPlJPXcVhF+t9atZg32R4vcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iSxt4MiSN2+pUu+lNq7PccXzeNZjJyeLoo7H5cm6MmxXqDQly2EvYJGoU6knYe7wN
	 bBrLgTlsMVQM41rbXMwsDqzgqcbVdun6y72leiy84Ithy94dk/3PL1b9rVz0vbmpS4
	 7pfEHiaqYhT8+vFGgNZcQW9j4jRcgoFJAk4LVwUoHlCuypJ/7wCUPUwX865TksYKEK
	 J2peSBoq6VXBCtFXuVVaihKkGJW/nT/Z0DE4luMSfySkin+2TqOa5rHEhs1BZmHSj/
	 EdU4Cu2XOwK582VQQf7aVNtHgeXMSHO7hYpqxI3CuG8GCtRB7NRXA5R3u+bYuoeqO6
	 uMiGJn/BS5ybg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604065519.112101-1-tshah@linux.ibm.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 07:06:16 +0000
Message-Id: <20260604070617.0050E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `process_sample_event()` function leaks reference counts and m=
emory associated with `struct addr_location` when a sample is skipped due t=
o time filtering.
--

commit de6e4710063f2942dd58ebe436d7d992872132b3
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data convert json: Fix trace_seq memory leak in process_sample_event()

This commit fixes a memory leak by ensuring trace_seq_destroy() is called
to pair with trace_seq_init() when formatting tracepoint raw data.

> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> index d526c91312ed8..6dd9349ab10f1 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_too=
l *tool,
>  				trace_seq_init(&s);
>  				tep_print_field(&s, sample->raw_data, fields[i]);
>  				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
> +				trace_seq_destroy(&s);
> =20
>  				i++;
>  			}

[Severity: High]
This is a pre-existing issue, but does the early return path for skipped
samples higher up in process_sample_event() leak the addr_location
reference handles?

tools/perf/util/data-convert-json.c:process_sample_event() {
        addr_location__init(&al);
        if (machine__resolve(machine, &al, sample) < 0) {
                pr_err("Sample resolution failed!\n");
                addr_location__exit(&al);
                return -1;
        }

        if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sam=
ple->time)) {
                ++c->skipped;
                return 0;
        }
        ...
}

When machine__resolve() populates the addr_location structure, it acquires
reference handles for objects like thread and map. The early return for time
filtering bypasses the addr_location__exit() cleanup.

Could this cause reference counts and memory to leak when dropping skipped
samples?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604065519.1121=
01-1-tshah@linux.ibm.com?part=3D1
