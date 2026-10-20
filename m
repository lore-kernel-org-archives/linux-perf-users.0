Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792511281;
	b=OGLOgOBGAwbkCIUPYNmOQCa/NzPbWR7uaikmmN3vVzDLO6PXJAyvZWSLaCH2NeDVlIgG
	 M/9hjnQhawKh5Z8snkScI+26K02HVkaVXJju21MJ+E8++lpLal/rw99En/WvaIUxKOqRI
	 Piw5GPZQgn0fpYYnu3IGXOUCQ8jS69NtzbFd4btD+6zYEzOyWRDJQYc8RE/vJrwNa5eG1
	 oEW2jsCPnrEPgKSOQM28u8RXOD+sXL2C5azovLJomTyYMMFeBadfEFmsdhZndLE0NF+FW
	 putVJc2QoWVsHe9gwFcQtV8EqmqyFbPcALWQDFnIYH+IiUC1LbT5KnEv1mdMZdBUT0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yRC6FlkraK3/GX/G0Bv3qFOVKgUroYX1xrJ2PWq82C4=;
	b=iIParBmPQWpC8sdBO0+hjA8cCMLpb1OnLcwN60V5ncy3dZFam4GvBe8dW0EhX8QVyD6M
	 RWt6z9YTR03zt9dLzhdjO5J50YaxA3dpLk0E4MRvd5F4tHrFMIR1v9al8VbhdaSme5iX0
	 U8R+SbhND8kwWEqEveK6AOG7RRwQqOEy+CbJcKJOCzUrRugbv1g7dDIUtBAXbXcqfE5ia
	 oimjJkMWvY6jUNLVo5p9vlNCNssXPfoKvZOZN9Yx126Qql6n4q8XMIEcGziSNfNDC5sz/
	 mDuKpILfU/veabvetcArgWdXGUSA4b215tuzaATssHAujtd2Zz5aisJYfVNXO46EEjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qSwuIXJA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C14606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C14606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qSwuIXJA
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5337c7b9937so364621cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 08:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792511275; cv=none;
        d=google.com; s=arc-20260327;
        b=GodsGjqogAI5SBOtpvU5vyqjbKZ8dmD8cARwYZoTFo0zZU1xX03qYkHkl131TFhSOQ
         Njv3EmxzWWsQKMh60wX9LGMFo2E3VAsNZCRI/tYw3+IX9mgwCtdKpEBAIV6jafq4yWSZ
         VAodbAiTQ7p/B5Jj0wD16ZR2F0RlkNWevDZhdrobRUOX2PJC4ldOFpnxQu53F3RT8Pdx
         NxkgSpmp+dcCXA4Ifuzo5mjoTrC+GooxVRaGsOKmS41VNwB9qiidmXY3IaqLtlAXBqXA
         tvyxuEm/DyZ0l2Irg9tfY3WP5fc6J73+G7Te2aEHB6OVlAHAeAmNsi5Nhiw7SCG4aw/Z
         /QAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRC6FlkraK3/GX/G0Bv3qFOVKgUroYX1xrJ2PWq82C4=;
        fh=3x/euKzTv3iRkSgFzKnxJsFK844XCIXHKCAPlJ11b9Q=;
        b=iM5uyu3LcIOCssbR1efMNVTqrRpzlC+rMl86zDdq783wgSU/YfnyBCDtI2a42mivXD
         fsg31+EJCGph4sFJfQ+9KQ47oZ2Z6XTS5ejXSSnNCZ12+tHT1d5ThlMpS4LU3AI0eabh
         Ts9cQXKlJmHi7OEFZ2yOjFIX+VQjep9LPnmsOaY8yfSwsXz6D1sj4C9Zf0L7jyflgxEh
         9Cp3YrENIB8oocCcs2cQV7vbD2LOurGLSvN7KvhaZCYSegfEhlOKwsG5HZIB7FOiwDeF
         X9cpuSXbpIdZJjMBxCwVz+Q3OPEFWHbORTRCXncBajwLLjbvrCtO0AkDJWaVT7p4W3zz
         JKUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792511275; x=1793116075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRC6FlkraK3/GX/G0Bv3qFOVKgUroYX1xrJ2PWq82C4=;
        b=qSwuIXJAgpoCsSGWpxrRfhS5fWBq6K8db5yEtTkjsuxjI3mq2WGFEMDzMK6tA2Z8+p
         4OIP+EzCO/ujp0lzITIRCfUz4P5IOGyKf5H/l1ShgJaWJndKaIg/m3t9J94hApwe4ly2
         o+M66QL6zsNMonLk/cossqvHi/mTQaUqeI/ODFISttFIUFzotknj94R7xTfPgFqXBT9K
         Ql8WPSf2kOmn3bzLzalp5l/bH2rPMZkRxh0TR2IwoErrWCtzq787xajSUJo80UPg98eF
         pCGyfd/OiPHHYVUfmd2Zd50ZyRTfR6FPS8F1S47qVHhKWdW6PbBqDepiAFFTKBW6macL
         gSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511275; x=1793116075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRC6FlkraK3/GX/G0Bv3qFOVKgUroYX1xrJ2PWq82C4=;
        b=gqTQNvlhK8b5o9+ZnpSaKvH2siJwczT2t26aFoBeoNE7KQPFWR7mYD0J+aGhVL2KKo
         sAny5teGEsH9kQaABCBPXjOTDxQNjuPYvsyAhlHO2KZvLq+j3qlFN6IIFXpvLQFUXv4m
         71H33VlLOKZ4mZ03n4mmpa+MmIUtEXB5OOPhTjAJ6swHjNssDX4xcJT6n5Or/0GlF9Hl
         +uzIPMtNUT2ERVxnuBhL17BNOEWU/qP2KSXkc+52ynSbEy7i1RSH0soE39G4kB8Mrk2t
         P8oIsWvg+SKRmnkBmnfHbwl9lqYmgicC/Vi4PQEdM6JrxwbY+vILlPUGxciPqCztqcEY
         Cj4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgdwfd1W2RjSL4/JdUElR4rsrO9Gnq1+G3PfiKNabqbVVv+jtAdDI/d1JXCBWCiZxTfJOQ6+OKv3w5C1sD9hW7@vger.kernel.org
X-Gm-Message-State: AFq9FYI84IlChmg2BFNqJW2Idy6vaiWD3KtmViTu15Rf3LeAXLyqmRe7
	83uDLIn3rUlEFhnk429q1E18k6ao5RH0SjJXxLW8rZhAVqYSUpX5D7F/7MXY91OQVAvo9n9JG6I
	Da8PCFR7bVMYS54G1ewVQvwY1JArMJILYi+Q92xPL
X-Gm-Gg: AYBFou02KfisWeD2kWVAFxv5kUcg7H5pB49agFWI21ecig5Op4nyqgeLFf+kguk8v36
	TwnYEZMBH1/qK02hgPf2yI+oujd9BCmAzNctqZXbZRzvEcqaqW5UNwi4llpUACTz8WE2rH21z3T
	15T1pWD57X00Kl5VU4my4JYDdZ7pOpTVA7qn6XaHceIPRj0CXL2FPHnDdccVlQ2mTIUGeY/KtaJ
	q7+g1BHDCUkwOZdQHOuDzKQblIjZUVzuC5GU2jSQBrlPY/BhgIkpYZ2XFFYN6HWKsNlAvG1xVDw
	oiQ/i0EkDcIvnKSiBysk06EFJSHShtfVL5J6dHWAnpsZDGvhdp5qq6ABehu7mPMHDqwnYpM6gJq
	B1Ixp3uD+8Bg42cJdabKT
X-Received: by 2002:a05:622a:408e:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-53684d0ca3fmr22835561cf.1.1792511274816; Tue, 20 Oct 2026
 08:47:54 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020053226.55936-1-namhyung@kernel.org>
In-Reply-To: <20261020053226.55936-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Oct 2026 08:47:43 -0700
X-Gm-Features: AclHuK-6g8Wi7TBC4FmkP0REbUcITyrib4F3WWwrmPcVPR9OBYT6u41SvbVECLM
Message-ID: <CAP-5=fVmn-xYGdMVKq5b6at2oqagXhVrj7a=r65Z80dLGa_DGg@mail.gmail.com>
Subject: Re: [PATCH] perf bpf-filter: Fix memory leak on bpf_link
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Attaching BPF program returns bpf_link but it leaked like following.
>
>   =3D=3D51328=3D=3DERROR: LeakSanitizer: detected memory leaks
>
>   Direct leak of 1568 byte(s) in 28 object(s) allocated from:
>       #0 0x7ffbe76ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId:=
 61e8165ca90f7a4f06b73f064a938c76deaae079)
>       #1 0x000000625df7 in bpf_program__attach_perf_event_opts (tools/per=
f/perf+0x625df7) (BuildId: 5e6309fda155e58708e92f1c76d44cadd585d0eb)
>       #2 0x000000beddc0 in perf_bpf_filter__prepare util/bpf-filter.c:507
>       #3 0x0000008f3def in evlist__apply_filters util/evlist.c:1421
>       #4 0x00000044bbcf in record__open  tools/perf/builtin-record.c:1469
>       #5 0x000000453f9e in __cmd_record  tools/perf/builtin-record.c:2594
>       #6 0x00000045dadb in cmd_record  tools/perf/builtin-record.c:4427
>       #7 0x0000005df56b in run_builtin  tools/perf/perf.c:383
>       #8 0x0000005dfa0e in handle_internal_command  tools/perf/perf.c:436
>       #9 0x0000005dfddc in run_argv  tools/perf/perf.c:480
>       #10 0x0000005e0333 in main  tools/perf/perf.c:581
>       #11 0x7ffbdd450680 in __libc_start_call_main (/lib64/libc.so.6+0x36=
80) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #12 0x7ffbdd450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so=
.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #13 0x000000409c54 in _start (tools/perf/perf+0x409c54) (BuildId: 5=
e6309fda155e58708e92f1c76d44cadd585d0eb)
>
>   SUMMARY: AddressSanitizer: 1568 byte(s) leaked in 28 allocation(s).
>
> Let's add an xyarray of bpf_link for the filters and release them at the
> end to fix the leaks.

As Sashiko noted, libbpf's bpf_program__attach_perf_event_opts() is
designed for callers that transfer ownership of the perf_event fd to
the returned bpf_link (such as bpf_program__attach_kprobe(), which
opens its own perf_event fd internally). When bpf_link__destroy() is
called, bpf_link_perf_detach() unconditionally disables and closes
perf_link->perf_event_fd:

      static int bpf_link_perf_detach(struct bpf_link *link)
      {
              struct bpf_link_perf *perf_link =3D container_of(link,
struct bpf_link_perf, link);
              int err =3D 0;

              if (ioctl(perf_link->perf_event_fd,
PERF_EVENT_IOC_DISABLE, 0) < 0)
                      err =3D -errno;

              if (perf_link->perf_event_fd !=3D link->fd)
                      close(perf_link->perf_event_fd);
              close(link->fd);
              ...

Since evsel->core.fd owns FD(evsel, x, y) and evlist__close() closes
those descriptors before evsel__exit() -> perf_bpf_filter__destroy()
runs, calling bpf_link__destroy() ends up closing FD(evsel, x, y) a
second time (and my v4 patch 2 has the same issue on FD(evsel, 0, 0)
by assigning skel->links.perf_tp_sample_filter =3D link).

Instead of using bpf_program__attach_perf_event_opts() and tracking
bpf_links, how about attaching the program directly with
ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd), just like the
pinned filter path right above it in perf_bpf_filter__prepare()
already does?

            fd =3D bpf_program__fd(skel->progs.perf_sample_filter);
            for (x =3D 0; x < xyarray__max_x(evsel->core.fd); x++) {
                    for (y =3D 0; y < xyarray__max_y(evsel->core.fd); y++) =
{
                            ret =3D ioctl(FD(evsel, x, y),
PERF_EVENT_IOC_SET_BPF, fd);
                            if (ret < 0) {
                                    pr_err("Failed to attach perf
sample-filter\n");
                                    goto err;
                            }
                    }
            }

That avoids allocating struct bpf_link_perf and extra BPF_PERF_EVENT
link fds altogether (fixing the leak without needing
evsel->bpf_links), avoids the double-close on FD(evsel, x, y) since
the kernel's _free_event() -> perf_event_free_bpf_prog() detaches the
program when evlist__close() closes the perf_event fd, and also lets
us drop pe_opts (.dont_enable =3D true) and the
LIBBPF_CURRENT_VERSION_GEQ(1, 7) guard.

For simplicity, I will include a patch doing this in v5 of my series.

Thanks,
Ian
