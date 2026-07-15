Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876414483B1;
	Wed, 15 Jul 2026 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114558; cv=none; b=pX03idJlzFw41MEM/bJERDlT7Y66SWZh7+8RrIBMHf45LUvFkMO3OqcZGptznQc7xKYejDeDUfKfLilj7LThrfJdX/8x4/Fc4S8CMDPdJuLc2+88rJB4JBgYQkIxHcjg8gyfinsaXMb/Rrm0y06ypWNAbdKUDvxRNoNmaZG/mIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114558; c=relaxed/simple;
	bh=paLY60KRj29oVMlzBB9uHqNmdYHfjVOCagkv9WxblgA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mM30+Vv1uSDxo2wIFhzh3ipMglktEM2TDYrGw8mh+CulpzfG3PhpkpYPbUAxA3KMWSFEKh+Vuc0msajYBGM1vVftRi5YQkHSh9l6oHnMqWpfwBnbz/v5PFaHYU6Vr88HcSC9q57/QIlfosBeBmLAzH67gf1JhfOdeQpYvNWvHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=RU6ehpTF; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="RU6ehpTF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To; bh=tLsRGD6ZEG0vyyRicAU5S0BQ59Bdz0F2XXwKAZKUVBw=; b=RU6ehpTF8h21qaH7
	mOO0Ga9fPlFPAjb9BMI/eKBHpt8yEWJRHIl0eW8W99/Bp8CmySv2NH2dgvdMCR7vfViLIcJIf9twd
	D7uGsN2JEIwbJpX1eZzkfcwY9QZ7krPI62IZhAyDYO8S3YY0Nk5oRaJQewVd+IjPpzLFeG4vbsTRI
	YvfFTfI4RkAXuc4xaEoOfwc/cKOkEskEDgl5tmw6REi4cRK3ji259gNcwqXpqhaLQpnrptmwTUiHE
	AjLzXv5BJFB93gl3J3CwZXwb/TR8LChGB17MohsqEi36VAXLr7/g/HV4PhFzHazhCfXMzi70rMfFW
	E3IRSe60aRpNanwRYw==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178] helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wjxgg-00DbpV-1r; Wed, 15 Jul 2026 12:22:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2026 12:22:03 +0100
From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Sandipan
 Das <sandipan.das@amd.com>, Chun-Tse Shao <ctshao@google.com>, John Garry
 <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf jevents: Add more components to the metric
 sorting order
In-Reply-To: <20260707034019.241762-2-irogers@google.com>
References: <20260707034019.241762-1-irogers@google.com>
 <20260707034019.241762-2-irogers@google.com>
Message-ID: <0cb89290ad307e4c1d020997a24a9662@codethink.co.uk>
X-Sender: nazar.kazakov@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: nazar.kazakov@codethink.co.uk

On 2026-07-07 04:40, Ian Rogers wrote:
> Nazar Kazakov reported non-deterministic builds due to the metrics
> being reordered in the jevents.py output. The metrics were largely
> only being sorted by name, add in the expressions and descriptions.
> 
> Reported-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> Closes: 
> https://lore.kernel.org/linux-perf-users/20260706175624.692736-1-nazar.kazakov@codethink.co.uk/
> Fixes: 40769665b63d ("perf jevents: Parse metrics during conversion")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 5 +++--
>  tools/perf/pmu-events/metric.py  | 6 +++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py 
> b/tools/perf/pmu-events/jevents.py
> index 376dc2d24162..3c6cfeefbd5d 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -570,13 +570,14 @@ static const struct pmu_table_entry 
> {_pending_events_tblname}[] = {{
>  def print_pending_metrics() -> None:
>    """Optionally close metrics table."""
> 
> -  def metric_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +  def metric_cmp_key(j: JsonEvent) -> Tuple[str, str, str, str]:
>      def fix_none(s: Optional[str]) -> str:
>        if s is None:
>          return ''
>        return s
> 
> -    return (j.desc is not None, fix_none(j.pmu), 
> fix_none(j.metric_name))
> +    return (fix_none(j.pmu), fix_none(j.metric_name), 
> j.metric_expr.ToPerfJson(),
> +            fix_none(j.desc))
> 
>    global _pending_metrics
>    if not _pending_metrics:
> diff --git a/tools/perf/pmu-events/metric.py 
> b/tools/perf/pmu-events/metric.py
> index a91ccb5977f0..11c7162825f4 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -623,7 +623,11 @@ class Metric:
> 
>    def __lt__(self, other):
>      """Sort order."""
> -    return self.name < other.name
> +    if self.name != other.name:
> +      return self.name < other.name
> +    if not self.expr.Equals(other.expr):
> +      return self.expr.ToPerfJson() < other.expr.ToPerfJson()
> +    return self.description < other.description
> 
>    def AddToMetricGroup(self, group):
>      """Callback used when being added to a MetricGroup."""

Tested-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

This fixes the non-reproducibility indeed, thank you!
I haven't tested mypy patches as I've just cherry-picked this one.

Thanks,
Nazar Kazakov
