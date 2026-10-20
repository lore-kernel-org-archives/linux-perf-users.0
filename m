Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485211;
	b=ADDUZNHSpCSbsG0XqR4U2SoXHyus8VDl3vkD0gn71vHmO+t8KiNXsTNbt+rPF4ZGcvGH
	 y1bNauINQeBD/8dRXZMyKg13o4+bLPPM+M2W4jsQLsnB7/hT87kOIw8Cue8HM0ax87fSg
	 llhAJONIAcfVnm2JvtZYN6ijI+JtpY0yVm/7hjoLmfGfyp04mwPBSPw6jrSAk+zTE/H+t
	 tbCVZyS4XAxjqwgQ0gPNU/UVaTAR9K3puqP6t8+JcjHf8GFdfzmYWLaWc4nxvbSUkMqZd
	 rtSNTo46Y47q4e2QPQzMVcJ4Xd6B5z3z/DqVEKZeeaVqfUyubFUKArJJd1J9ivHAkxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/srvRsllgJK9NvouJ4AGy1/T8p1DtBULgSkRpNG0fvE=;
	b=eqO4gclWKjigyTLavmy5MT3bvZp+TmQFUu6yc2TithqJ5sl7WGM1fb6ANWOH0bHPdGva
	 apjt0OAPpi/dI1wRNExSqoJ41TiE5qkgPhksBRdcqcI0Ahv5aZ5Yj1jq6HUdMW2ivpMx3
	 gThWDjsMsl8GHr19bjAqVjpcDpuzEVYJV7BtpsyqV3W3QycArkQ6HlbIuZho8IA5JB+5/
	 MuSwLXE1tzRpjZUBKOY5YRZt9E+8ffT+pwSYHQOks7A5CsVWLfllIGNbs0pTwJeN9c+Qx
	 pQf/7o/YEssOrzo8N2tWixpK58xhdtMjC6FqGStMay84izZw/6PsTB2JqHOuk/jALaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAPjsGHB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E161606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAPjsGHB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB381F000C4;
	Tue, 20 Oct 2026 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485210;
	bh=/srvRsllgJK9NvouJ4AGy1/T8p1DtBULgSkRpNG0fvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAPjsGHBywpFZcofOZJ91cddaOVMFEQu7DR3JLzjIy0CEj1/PQsEv81hhTNVtLf1+
	 6/D1rW/B9lJ0Rgh6xBDHnDolClbIY5xRO7Ce1jiHuX7BLUcDO3wl43h8aOwFBX3N2N
	 JXsEKmp8O5bEBVlPAznmXKZdR11dic3ooC1H8sHPbFWSjqDbNjI2ate5hnDzIbH6kM
	 y7ey+4bQ2h8jgXee0lVXyZRZIeryAICmUUv8nShrWs5qJV+Q4C0Mi6EgV7loBH70sm
	 R4/ZzM+Kexxq3gLQ8yGI24lye62f6znTXuwhdaFBMAPYpJTXofxeyjTSlziO57LqPm
	 /zvbFIlDJy1IQ==
Message-ID: <sashiko-outbox-178566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bpf-filter: Fix memory leak on bpf_link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020053226.55936-1-namhyung@kernel.org>
References: <20261020053226.55936-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:33:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: double close of perf_event fd in bpf_link__dest=
roy()
- [Medium] perf bpf-filter: incorrect IS_ERR() check in perf_bpf_filter__pr=
epare()
--

commit 0bafd46f68639fd52d99226001cedebcf8838c32
Author: Namhyung Kim <namhyung@kernel.org>

perf bpf-filter: Fix memory leak on bpf_link

This commit stores the bpf_link pointers returned when attaching BPF sample
filters in an xyarray on the evsel and destroys them on cleanup and error
paths to fix a memory leak.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index bcd81084e3420..664484703fc3d 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -66,6 +66,7 @@
>  #include "bpf_skel/sample_filter.skel.h"
> =20
>  #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> +#define LINK(e, x, y) (*(struct bpf_link **)xyarray__entry(e->bpf_links,=
 x, y))
> =20
>  #define __PERF_SAMPLE_TYPE(tt, st, opt)	{ tt, #st, opt }
>  #define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PBF_TERM_##_st, PE=
RF_SAMPLE_##_st, opt)
> @@ -526,6 +527,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, st=
ruct target *target)
>  		goto err;
>  	}
> =20
> +	evsel->bpf_links =3D xyarray__new(xyarray__max_x(evsel->core.fd),
> +					xyarray__max_y(evsel->core.fd),
> +					sizeof(link));
> +	if (evsel->bpf_links =3D=3D NULL) {
> +		ret =3D -errno;
> +		pr_err("Failed to allocate bpf links\n");
> +		goto err;
> +	}
> +
>  	prog =3D skel->progs.perf_sample_filter;
>  	for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
>  		for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
> @@ -536,6 +546,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, str=
uct target *target)
>  				ret =3D PTR_ERR(link);
>  				goto err;
>  			}
> +
> +			LINK(evsel, x, y) =3D link;
>  		}
>  	}
>  	free(entry);
> @@ -553,6 +565,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, st=
ruct target *target)
>  			free(pfi);
>  		}
>  	}
> +	if (evsel->bpf_links) {
> +		for (x =3D 0; x < xyarray__max_x(evsel->bpf_links); x++) {
> +			for (y =3D 0; y < xyarray__max_y(evsel->bpf_links); y++) {
> +				bpf_link__destroy(LINK(evsel, x, y));
> +			}
> +		}
> +		xyarray__delete(evsel->bpf_links);
> +		evsel->bpf_links =3D NULL;
> +	}

[Severity: Medium]
Can this error cleanup block ever be reached when attaching fails?

In perf_bpf_filter__prepare(), the attachment loop checks the return value
of bpf_program__attach_perf_event_opts() with IS_ERR(link):

tools/perf/util/bpf-filter.c:perf_bpf_filter__prepare() {
	...
	for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
		for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) {
			link =3D bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
								   &pe_opts);
			if (IS_ERR(link)) {
				pr_err("Failed to attach perf sample-filter program\n");
				ret =3D PTR_ERR(link);
				goto err;
			}

			LINK(evsel, x, y) =3D link;
		}
	}
}

However, in tools/lib/bpf/libbpf.c, bpf_program__attach_perf_event_opts()
returns libbpf_err_ptr(err) on failure, which sets errno and returns NULL
rather than an error pointer:

tools/lib/bpf/libbpf.c:bpf_program__attach_perf_event_opts() {
	...
	return &link->link;
err_out:
	if (link_fd >=3D 0)
		close(link_fd);
	free(link);
	return libbpf_err_ptr(err);
}

Because IS_ERR(NULL) is false, an attachment failure stores NULL into
LINK(evsel, x, y) and continues instead of jumping to err, leaving the
evsel->bpf_links cleanup at err unreachable and returning 0.

>  	sample_filter_bpf__destroy(skel);
>  	return ret;
>  }
> @@ -566,6 +587,17 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
>  		list_del(&expr->list);
>  		free(expr);
>  	}
> +
> +	if (evsel->bpf_links) {
> +		for (int x =3D 0; x < xyarray__max_x(evsel->bpf_links); x++) {
> +			for (int y =3D 0; y < xyarray__max_y(evsel->bpf_links); y++) {
> +				bpf_link__destroy(LINK(evsel, x, y));
> +			}
> +		}
> +		xyarray__delete(evsel->bpf_links);
> +		evsel->bpf_links =3D NULL;
> +	}
> +

[Severity: Medium]
Does calling bpf_link__destroy() here and in the error path of
perf_bpf_filter__prepare() cause a double close on the perf_event file
descriptors in evsel->core.fd?

In perf_bpf_filter__prepare(), FD(evsel, x, y) is passed directly to
bpf_program__attach_perf_event_opts(), which stores that descriptor in
perf_link->perf_event_fd and sets the detach callback to
bpf_link_perf_detach().

When bpf_link__destroy() is later called, bpf_link_perf_detach() disables
and closes perf_link->perf_event_fd in addition to link->fd:

tools/lib/bpf/libbpf.c:bpf_link_perf_detach() {
	...
	if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
		err =3D -errno;

	if (perf_link->perf_event_fd !=3D link->fd)
		close(perf_link->perf_event_fd);
	close(link->fd);
	...
}

During normal teardown in evlist__put(), evlist__close() closes all
FD(evsel, x, y) descriptors before evlist__purge() -> evsel__put() ->
evsel__exit() -> perf_bpf_filter__destroy() runs:

tools/perf/util/evlist.c:evlist__put() {
	...
out_delete:
	evlist__free_stats(evlist);
	evlist__do_munmap(evlist);
	evlist__close(evlist);
	evlist__purge(evlist);
	evlist__exit(evlist);
	RC_CHK_FREE(evlist);
}

As a result, bpf_link__destroy() in perf_bpf_filter__destroy() performs
ioctl() and close() on FD(evsel, x, y) after it has already been closed.
Similarly, if perf_bpf_filter__prepare() fails partway through attaching
and jumps to err, bpf_link__destroy() closes the attached FD(evsel, x, y)
descriptors while leaving their positive FD numbers in evsel->core.fd, so
a subsequent evlist__close() closes them a second time.

>  	sample_filter_bpf__destroy(evsel->bpf_skel);
> =20
>  	list_for_each_entry_safe(pfi, pos, &pinned_filters, list) {

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020053226.5593=
6-1-namhyung@kernel.org?part=3D1
