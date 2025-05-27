Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2C1F4192;
	Tue, 27 May 2025 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379441; cv=none; b=e1/QDpBsQ7K+x77NQBPWBldFGN0VLgkiyXRbZssVAUVDft/jOr0BKRwaB+3EbJu9egQ6z+2TsoRgSbz90Cc8Gzv9GGjucwqcfDutiGQBxZ9ucJPsD6KEKEuh19UFRAd9VJe9uJqv/5AR4GEDCUv4mlAmak1ci0Y0E//Q68dkvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379441; c=relaxed/simple;
	bh=otShwg+JlfW9/k5L2H6WnNxBlpqUK+kGSbFILKFdPoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIG/tRuQBOG27l4A/ahOqGf7ljOq+Y8oB62wnhXgFGWB1LoZRrs3kKk9gRd8vw/29Ac49myHuEejiT15J6isuA5VZ4l15MEHhFM0kVH5J7pClhIXrbMTFuNnH98bGyvZprbohVPwNsLXBi2SJ91b6E8P4oz3r834biGUitVgUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB2AbNqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB2AbNqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FB6C4CEE9;
	Tue, 27 May 2025 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748379441;
	bh=otShwg+JlfW9/k5L2H6WnNxBlpqUK+kGSbFILKFdPoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XB2AbNqHLVxIuiMXO+rFXcHcB7VVFpEwWyKoS5NDuZLmeBZbXF8txZXMgZkUufF7U
	 2KSk+PfHLb7f+MjQU2j6bJWEWm1iFgyWK+17cQNeLv3BplBcKMJ0xBdq1HUEvNWAr3
	 T2NUUcb1Dl46SRTyrn81w0FPbp47bN8X1hj+j2SRv87axP+Cvwv5afJJjZz0nms4PG
	 62pCRj7K7pDohPJ7r0lOYIDSf7ILgWBrL6Yw/+IbE8EMj0xEd+GoZHclVF2OyWMplY
	 sVODJmAMuU4gKlcAbkJtcTKTJjCJSWHQA6McwWXduix4P+GNzFKNY/F1SE2WGtFKXm
	 wUW0uU4ZTfRYw==
Date: Tue, 27 May 2025 17:57:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu: Avoid segv for missing name/alias_name in
 wildcarding
Message-ID: <aDYnLedM8RT17FHx@x1>
References: <20250402211301.4153441-1-irogers@google.com>
 <Z_Af-KAKuOlqALH6@google.com>
 <CAP-5=fUiWm9kq2fhT-9+8LOmC2Yen9Mw2P8yPLTJH+nk83nmmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUiWm9kq2fhT-9+8LOmC2Yen9Mw2P8yPLTJH+nk83nmmA@mail.gmail.com>

On Tue, May 27, 2025 at 01:33:35PM -0700, Ian Rogers wrote:
> On Fri, Apr 4, 2025 at 11:07 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Wed, Apr 02, 2025 at 02:13:01PM -0700, Ian Rogers wrote:
> > > The pmu name or alias_name fields may be NULL and should be skipped if
> > > so. This is done in all loops of perf_pmu___name_match except the
> > > final wildcard loop which was an oversight.

> > > Fixes: c786468a3585 ("perf pmu: Rename name matching for no suffix or wildcard variants")
> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Ping.

⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./20250402_irogers_perf_pmu_avoid_segv_for_missing_name_alias_name_in_wildcarding.mbx
patching file tools/perf/util/pmu.c
Hunk #1 FAILED at 2060.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/pmu.c.rej
⬢ [acme@toolbx perf-tools-next]$ 

⬢ [acme@toolbx perf-tools-next]$ cat tools/perf/util/pmu.c.rej
--- tools/perf/util/pmu.c
+++ tools/perf/util/pmu.c
@@ -2060,7 +2060,9 @@ static bool perf_pmu___name_match(const struct perf_pmu *pmu, const char *to_mat
 	}
 	for (size_t i = 0; i < ARRAY_SIZE(names); i++) {
 		const char *name = names[i];
-		
+
+		if (!name)
+			continue;
 		if (wildcard && perf_pmu__match_wildcard_uncore(name, to_match))
 			return true;
 		if (!wildcard && perf_pmu__match_ignoring_suffix_uncore(name, to_match))
⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/util/pmu.c
754baf426e099fbf perf pmu: Change aliases from list to hashmap
255f5b6d060be5a4 perf parse-events: Add "cpu" term to set the CPU an event is recorded on
fa1332a8011eebe1 perf mem/c2c amd: Add ldlat support
fc807b6bde6ad332 perf pmu-events: Add retirement latency to JSON events inside of perf
58b8b5d142a8bd5c perf cpumap: Increment reference count for online cpumap
⬢ [acme@toolbx perf-tools-next]$ 

Can you please take a look?

- Arnaldo
