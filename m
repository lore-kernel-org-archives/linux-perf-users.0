Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B622AD00
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989702; cv=none; b=OQ5PUl6064+S1akvYya0KTDEnLMqmFFoT/UIy7AcG6Vuw6GG4y5zBmmhWpbCIVMELlusyvTGXPmf0lkbdM3o5AIkuLZLNYQJSP0rqsBfkq/85nsWAhCyGxb+4qQZ3m/mCg3KGlwm+v95i0aRdiaVBrpMItRcB9UQCN4rAc1LRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989702; c=relaxed/simple;
	bh=kt1uYRKw9nqcylTEKcR+JsRmAQVk3WvZlsf5Ql4LZXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROh+162hzykEfJbX8FqS8RyqRKdsVZw/E5SF4SCwujZTS4qEbOq3eBFvOrL6MzVIJkkAMIpNUyedGgPdEv/tragI8k3w55Hszqv6xfLEuGNdAvPWUVGwAIcMHkBrbdIQ62KUANzg6Cl/tSpm1Jb1/fqMtUr3+zNznQNPlgfLuc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKh89tfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKh89tfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C981F00893;
	Tue,  9 Jun 2026 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989700;
	bh=A4IeuHtx2901m7fLaR+rMjVX14NUMHf/LJDapDisKxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKh89tfLKRagdyt/AWB+rYoyT6lH1jZGF03Dm9tGrNMqBqWNIqf868jvcqtV23UOU
	 U5bKTIbOKsOqhj6Io1b4nAZdGBja/rh1DtpTmir/5np+o/vJrYOVwT2okgZwFpbzYq
	 T+tZBsFsMU24ePadcJHIhmEDjuulEIsnLk0yxbUOVJ8cg2Dbc/tQ562XzP6fCeH7xA
	 63o0YeagEu+iE34p1NhxVzCbRRYXCPIchvvjyE03o+puZUSadfPSG85183oewFnUNV
	 Xuzb9pXHIrjENrcONLMz4RwBYxdiOggUChAmYIhIhlK1uQaXAcOImXIUq/efMgDyXe
	 J6PvoFPZQhKnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] perf pmu: Implement tool-provided NVMe PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609070348.541964-3-irogers@google.com>
References: <20260609070348.541964-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:21:39 +0000
Message-Id: <20260609072140.70C981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unaligned memory access and strict aliasing violation in nvme_pmu_=
_read_val() due to byte-aligned stack array cast to wider types.
- [High] The NVMe PMU implementation hijacks the tool-owned `evsel->priv` f=
ield, leading to arbitrary memory corruption and memory leaks.
--

commit 444d6a9adc97df412d7040ffe34f89b94548c30b
Author: Ian Rogers <irogers@google.com>

perf pmu: Implement tool-provided NVMe PMU

This commit adds a tool-provided PMU for NVMe devices using libnvme to
expose metrics from various NVMe logs as perf events under the
nvme_nvmeX PMUs.

> diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
> new file mode 100644
> index 0000000000000..17ba758aec59b
> --- /dev/null
> +++ b/tools/perf/util/nvme_pmu.c
[ ... ]
> +static int nvme_pmu__read_val(int fd, uint64_t config, uint64_t *val)
> +{
> +	int log_type =3D (config >> 24) & 0xFF;
> +	unsigned int size =3D (config >> 16) & 0xFF;
> +	unsigned int offset =3D config & 0xFFFF;
> +	uint8_t buf[4096];
> +	uint8_t *p;
[ ... ]
> +	p =3D buf + offset;
> +	if (size =3D=3D 16 || size =3D=3D 8)
> +		*val =3D le64_to_cpu(*(uint64_t *)p);

[Severity: High]
Does this cast violate C strict aliasing rules and risk unaligned memory
access crashes?

Since buf is a byte-aligned stack array and offset can be an arbitrary
value, p is not guaranteed to be 8-byte aligned. On architectures that
strictly enforce memory alignment, dereferencing an unaligned 64-bit
pointer can cause an immediate bus error (SIGBUS).

Additionally, casting a byte array to a wider type violates strict aliasing,
which is enforced in the tools/ directory with -fstrict-aliasing.

Could we use get_unaligned_le64() here instead?

> +	else if (size =3D=3D 4)
> +		*val =3D le32_to_cpu(*(uint32_t *)p);
> +	else if (size =3D=3D 2)
> +		*val =3D le16_to_cpu(*(uint16_t *)p);
> +	else if (size =3D=3D 1)
> +		*val =3D *(uint8_t *)p;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
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
> +	if (!evsel->priv) {
> +		int max_cpus =3D evsel->core.cpus ? perf_cpu_map__nr(evsel->core.cpus)=
 : 1;
> +
> +		evsel->priv =3D xyarray__new(max_cpus, nthreads, sizeof(uint64_t));
> +	}

[Severity: High]
Can this leak the xyarray allocation?

Since evsel->priv is conventionally owned by the specific perf tool executi=
ng
the command, allocating an xyarray here does not seem to have a matching
destructor for the PMU, which might leave the memory unfreed when the event
is closed.

> +
> +	for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> +		for (thread =3D 0; thread < nthreads; thread++) {
> +			int fd =3D open(path, O_RDONLY);
> +
> +			FD(evsel, idx, thread) =3D fd;
> +			if (fd < 0) {
> +				err =3D -errno;
> +				goto out_close;
> +			}
> +			if (evsel->priv) {
> +				uint64_t *initial_val =3D xyarray__entry(evsel->priv, idx, thread);
> +
> +				if (nvme_pmu__read_val(fd, evsel->core.attr.config, initial_val))
> +					*initial_val =3D 0;
> +			}

[Severity: High]
Is there a risk of memory corruption if a tool has already populated
evsel->priv?

If an active tool like perf stat has already set evsel->priv to its own
structure, this code assumes it is an xyarray. The xyarray__entry()
function will read from the tool's struct to compute a pointer offset,
and then nvme_pmu__read_val() will write a 64-bit value to that
invalid address, causing arbitrary heap corruption.

> +		}
> +	}
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070348.5419=
64-1-irogers@google.com?part=3D2
