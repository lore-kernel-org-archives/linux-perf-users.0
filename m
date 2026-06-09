Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50754BCAC2
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025553; cv=none; b=YwIHAgTUwEb5Mudjh4wd4PxQexN+vRwul+Eg7rk7Lln9hR6ZQyIOVyNOrI6M13S5BvNYGPHGhuAdSQm+Wa9kkWNkj+s3frxkOHre9utOvv0yMeRCk13X1q6GD31fceNJaTZtp2M/Tkp8D9XlR1iysWDKF8WzoWmzVWhwHnd7teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025553; c=relaxed/simple;
	bh=WLdLqCzWq9nUMzyBGl39FkHYHp2Oxbh+X48fOlS/Uo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6x0RhETt/fmuvRAmI29m+v8sKzBubQiZDtXTTQ9q3vxBsrchSQKk9w97k7FQ+ivSBCn5Wtj6n4tQzgyrA/nxtw/Ln1fUlJrvRsSBnWLxZUH5TVX8iirXX/zaj8JqryuHicNfOp2DVX2hTRzPS5BjV2G+NRWsD+nx+1PwKNu3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIAec8jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIAec8jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6041F00893;
	Tue,  9 Jun 2026 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781025552;
	bh=GdiPdHwQlCB1Oyh3mZ+0AhXuG4AYiNJcxL1Ibh53kG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIAec8jhcvHIcRVNc4QDkNg4hfjyfxCAztm0V0ceJEZrTBC4Sq0t5KeLuZFTeRVCL
	 jLISkN2dqB7zyNnTRmEmbgBsFID2vd7B64EUKhrFYlEbyEcB8hT4/6b7xaGGmMA5ci
	 9UsHL66mQ+pshORUJfsKpGOFdREjVbm3kYMvmjKpcI/Vb3UShC3A9cFYBrQ6H1hc5v
	 h98vl0sCRDnSil6PAYGlm53JRzUOR/GWFBLEbyazrpU9Fs/tSIreNnpY96LnQmK/aN
	 zfUEVZmo3vV7jPfqTwFJ1E7wsWfrQdvwMaoGjxesMbQ1kxjmNwqXFc+bng5F3nSwwc
	 sESfQhDjEFhMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf pmu: Implement tool-provided NVMe PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609165726.786694-3-irogers@google.com>
References: <20260609165726.786694-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:19:11 +0000
Message-Id: <20260609171912.1D6041F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Silent fallback on memory allocation failure for `evsel->nvme.init=
ial_values` leads to reporting absolute lifetime metric values instead of i=
nterval deltas.
- [High] Passing a potentially NULL `term->config` to `asprintf` with `%s` =
causes undefined behavior or crashes on certain libcs.
- [Medium] The PMU falsely advertises raw configuration encodings that it a=
ctively rejects.
- [Medium] Temperature conversion underflows for sub-zero Celsius values.
--

commit eb0821bb5f35088b9c452cacc4d9efb1228b06b1
Author: Ian Rogers <irogers@google.com>

perf pmu: Implement tool-provided NVMe PMU

Add a tool-provided PMU for NVMe devices using libnvme. This PMU exposes
metrics from various NVMe logs as perf events under the 'nvme_nvmeX' PMUs.

> diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
> new file mode 100644
> index 0000000000000..e2391726d76e7
> --- /dev/null
> +++ b/tools/perf/util/nvme_pmu.c
[ ... ]
> +static int nvme_pmu__config_term(const struct nvme_pmu *nvm __maybe_unus=
ed,
> +				 struct perf_event_attr *attr,
> +				 struct parse_events_term *term,
> +				 struct parse_events_error *err)
> +{
> +	if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER) {

[Severity: Medium]
In nvme_pmu__for_each_event(), the encoding description is formatted as
config=3D0x%lx. However, here in nvme_pmu__config_term() it seems only
PARSE_EVENTS__TERM_TYPE_USER is accepted.

Would this incorrectly reject valid config terms that match the advertised
encoding if a user manually specifies them? For example, if they were to
use a command like: perf stat -e nvme_nvme0/config=3D0x123/

> +		size_t i;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(nvme_events); i++) {
> +			if (!strcasecmp(term->config, nvme_events[i].name)) {
> +				attr->config =3D nvme_events[i].config;
> +				return 0;
> +			}
> +		}
> +	}
> +	if (err) {
> +		char *err_str;
> +
> +		parse_events_error__handle(err, term->err_val,
> +					asprintf(&err_str,
> +						"unexpected nvme event term (%s) %s",
> +						parse_events__term_type_str(term->type_term),
> +						term->config) < 0

[Severity: High]
If a user specifies a non-string config term like name=3Dmyname or a bare
number, the parser might create a term with a NULL term->config string key.

Does passing a potentially NULL term->config to asprintf() with %s cause
undefined behavior or a crash on certain libc implementations (like musl)?

> +					? strdup("unexpected nvme event term")
> +					: err_str,
> +					NULL);
> +	}
> +	return -EINVAL;
> +}
[ ... ]
> +int nvme_pmu__check_alias(struct parse_events_terms *terms, struct perf_=
pmu_info *info,
> +			  struct parse_events_error *err)
> +{
[ ... ]
> +	if (err) {
> +		char *err_str;
> +
> +		parse_events_error__handle(err, term->err_val,
> +					asprintf(&err_str,
> +						"unexpected nvme event term (%s) %s",
> +						parse_events__term_type_str(term->type_term),
> +						term->config) < 0

[Severity: High]
Similarly, this error formatting path also appears to suffer from the same
potential NULL dereference of term->config.

> +					? strdup("unexpected nvme event term")
> +					: err_str,
> +					NULL);
> +	}
> +	return -EINVAL;
> +}
[ ... ]
> +static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
> +{
[ ... ]
> +	if (log_type =3D=3D NVME_LOG_SMART) {
> +		if (offset + size > sizeof(struct nvme_smart_log))
> +			return -EINVAL;
> +		if (nvme_get_log_smart(fd, NVME_NSID_ALL, true, (struct nvme_smart_log=
 *)buf) !=3D 0)
> +			return -EINVAL;
> +
> +		if (offset =3D=3D offsetof(struct nvme_smart_log, temperature)) {
> +			uint64_t kelvin =3D ((struct nvme_smart_log *)buf)->temperature[0] |
> +					  (((struct nvme_smart_log *)buf)->temperature[1] << 8);
> +			*val =3D (kelvin * 1000) - 273150;

[Severity: Medium]
Does this temperature conversion risk an unsigned integer underflow for
sub-zero Celsius values?

If the NVMe SMART temperature in Kelvin drops below 0 degrees Celsius
(less than 273 K), kelvin * 1000 would be less than 273150. Since *val is
assigned to a uint64_t, this underflow could result in a massive value
being reported instead of a valid negative temperature.

> +			return 0;
> +		}
> +	} else if (log_type =3D=3D NVME_LOG_ENDURANCE) {
[ ... ]
> +int evsel__nvme_pmu_open(struct evsel *evsel,
> +			 struct perf_thread_map *threads,
> +			 int start_cpu_map_idx, int end_cpu_map_idx)
> +{
> +	struct nvme_pmu *nvm =3D container_of(evsel->pmu, struct nvme_pmu, pmu);
> +	int idx =3D 0, thread =3D 0, nthreads, err =3D 0;
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), "/dev/%s", nvm->dev_name);
> +
> +	nthreads =3D perf_thread_map__nr(threads);
> +
> +	if (!evsel->nvme.initial_values) {
> +		int max_cpus =3D evsel->core.cpus ? perf_cpu_map__nr(evsel->core.cpus)=
 : 1;
> +
> +		evsel->nvme.initial_values =3D xyarray__new(max_cpus, nthreads, sizeof=
(uint64_t));

[Severity: High]
What happens if xyarray__new() fails and returns NULL here?

It looks like the allocation failure is silently ignored, and the open
operation succeeds with evsel->nvme.initial_values left as NULL.
Later in evsel__nvme_pmu_read(), the baseline subtraction defaults to 0.

Could this cause the perf tool to silently report the absolute lifetime
device counter on the first measurement interval instead of the expected
interval deltas? Should this check for allocation failure and return
-ENOMEM instead?

> +	}
> +
> +	for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609165726.7866=
94-1-irogers@google.com?part=3D2
