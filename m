Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FE39021A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503759; cv=pass; b=Ryk2ldOAkJhdasSTpo60+nOLoCrcC5axWcdUDj53If7nvl/VNWtlciZI+5/h/IZ9VqSMqDVU56ShOeKTIyDbEWUcVmQ3WAaSyBduinmpM4INB2ffqPHKdQiqqQP1XVEyUetBzFOtYBES+MyZo0Y31IT0cimDXxlyjUOT6pQiMxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503759; c=relaxed/simple;
	bh=nxSIPLt/YeDW0q2ULPE0bA9S0rKsXfonlfZwCtpXKl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8riKc+WxTAwy+gjZzXZdCmxvSY2EILHZQM+Ib3Z71uVcSpek+7JQ4OkpgxGQ7Ie0F1UEkwCvnXD6TaLc1PLiuC5nICauS07KWdprFn/sXLBgayyT29Q0yh+unMh0mKBv3VJoQ5UxmC+M6sRzEdgg906AE1HlPXY4uMd0soG/aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnYOLi6I; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnYOLi6I"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so11641cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789503757; cv=none;
        d=google.com; s=arc-20260327;
        b=CHSC0CBE+r3FvPho4P0qkRSLJhwzKV/cbWK4oXfDAl2Xrbm2O5K4SMEkSbJ7QgWOXL
         EWwHcud4YRNbmcdX9t7sfmU4EB9hTZJbtC0Us8zPJRFXtOX/oLrpAf0tSGavOB1nZwuw
         57et9LdsxA8JnS4F1YZEXPyd7aZRCtK7PIfTBpaBjGQusL89G38ncre3fFXwzauZUDmN
         rAxHgmdS3Yz+jWLeubXdwP6i+j0PS/pPgNzERrPEZMWbQU3bHkK9iK6RG1CYjyKQs3hh
         5bC7jWfTaHjoWYBDR08NwNeRt0WANmsVIeDaxixqytS+A4tizrPtDthV5rXxgCbceOzy
         G/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxSIPLt/YeDW0q2ULPE0bA9S0rKsXfonlfZwCtpXKl4=;
        fh=MAzeeLADGi5XGTGrx8vtVQKHp8OUkTz21r9UpZR/45E=;
        b=IZSnzeAmExEr88xeFTxTv/zANGYYerawXvVB48Vy6JAtdde/p3VDnDe6NhBOyhqBJa
         0JzH0WuKHePshcOnvQeo42WONIMjFy4HA7qCXbJO9oM4YnOXgbsW8uWncpsnJHQAoQEg
         JYWw6kzxsVvsz+DyX2XOX0DmLcqPjnFFY+V4utHPn0McTfd3uc3OFYLIMWBDEMufWuH6
         MeYAtNoU6xSAkSPKQAMAblorPXvxvVCqNVvw3yAqn2Rdbk+W9QA2ppniDicdckPV6an2
         QmMlPRXVuBv7Uku/qGDQzPi6JFcp11UfdYKmcVorSHV376OKCG7ljsGKT/rS438dAKj4
         6Y3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789503757; x=1790108557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nxSIPLt/YeDW0q2ULPE0bA9S0rKsXfonlfZwCtpXKl4=;
        b=WnYOLi6IPAdNYSmNQZzSKbxVZPuAjVNinHwzLp/m7OYJCzjyqqQklCs7JDIwUk3CLl
         hbqYAIu2sULqmfa1ZF6FHsrf6F1K6sGB3LtWt8VXRmYKjJvCKh0HPVNcQfL4pAjckhek
         kH1h4kJ50TZ48JcOcBTHsvENpuoAWI3JYVN7Ah+9USKLkm4R/SaKhYkb+jiFQjFRG8Jd
         k3YcW8UUkJf7/Yb3ITL5CfLr2G0rY/lujMpwnyKGVRpH4CJiKHCitQ0Bgk5Pd38Et/qU
         oCOtC979HqsGOBbnZ/uzi2hLteABjfaJUzN8iKocGTTAsjPtyoivzwAfwaipzApnNlSL
         Ux/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789503757; x=1790108557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxSIPLt/YeDW0q2ULPE0bA9S0rKsXfonlfZwCtpXKl4=;
        b=1+T9sVWyWw/qPJ2vjTi4/T4IvZMAfxmBPf99Y8m6oGYoStj2dvRMzdoMtcrxLXFsj6
         fW6pW9I20QTQmOEcBHHJ5MG5cWYjs6DsEfTDhG0ktKp0lbbB+WHbBaPnXldAu5e2P+1/
         1L7N56K7ZbVs0g/cjqz1SNURuHWGP4/GlHjhLiklbeUMQXfDKQBbW4fuP95fF7c7tXkv
         5Zg8gImLw5lVV03O3apJaRxIPAbXGfWxKeUN8o+DljjmhzpvJ7yyHC8JpEduPZAMZQpN
         V+BeUcLIa/qGH4av5K4YMPLDQUTkq955aV2XTm0H8KW8AAgDE+QNbg8BtVV9J1X9hBOg
         fekg==
X-Gm-Message-State: AFuF++mRODhBtqp/8fpoSUhFP6BAj8E7ZK6QnRq84Ayg1drfPqf3t/aH
	VEJOyRK4SfqUmhJD0muaMuwy6+sJYoj8W5IixcuDYCExDEsXnaEUavuFzLudkR0itjOupWklMxF
	ji3rkIJ8Ox1w7CIzA0wjRtiqkuFpBRjvUyK5VJb4Y
X-Gm-Gg: AYBFou27ExjGGH4lRrDScZFWvNxq6kJ4+QI7QCdh+JSmTOPExYA3uAs03D+RSM+0j7F
	JGlvGos8Gm+0I2SXgFYDMiCQMFU8/+XWVnUZSPYSjfmPxOMn1kVsr5UEFc1OjHQ6HVZrJggiiRx
	2GMshZm/EuGwE+C9lpITvwxS6hwgNylgFQ/878u8oPhMEuOtvXOvic9OzmCi8wr+SuLottW7aX4
	3K06czsg4D1VQhJklZ3/8/qOEuuzqG1PNJZfIrHE/3ML1Dwf3Eo9CGFXJci+y0fr79iNymoZPfO
	cNwRb6INrzNo8JunYarzsY9d0P58OWJn5A/P3xAuIOy/O/0grJ0E91R31qeq85U6FmKs+xNAKLG
	OhKPklDDvPg==
X-Received: by 2002:ac8:5f8d:0:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-5327e6ab465mr107701cf.5.1789503755929; Tue, 15 Sep 2026
 13:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820200214.2865570-1-irogers@google.com> <20260820213757.2970316-1-irogers@google.com>
 <20260820214746.98B771F000E9@smtp.kernel.org> <CAP-5=fWRhOdjT+9wUqOy59Hz4fSZQgibanisytCy_3TNTN1ecg@mail.gmail.com>
In-Reply-To: <CAP-5=fWRhOdjT+9wUqOy59Hz4fSZQgibanisytCy_3TNTN1ecg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:22:24 -0700
X-Gm-Features: AcwNN1V4ghJonsd5n1VYZ771CMeh3jcyPlqntf-hnspW2Uen3GlKNn8OyuViFO0
Message-ID: <CAP-5=fUFYbvxEnEBJt5g1TFHxxTKkgVqLuTEnXUKWQ1qACGFNg@mail.gmail.com>
Subject: Re: [PATCH v8] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 3:00=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Aug 20, 2026 at 2:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > > When processing POLLHUP on a non_perf_event control descriptor,
> > > evlist__finalize_ctlfd() is invoked to finalize the setup, correctly
> > > setting the core evlist's poll array file descriptor to -1. However,
> > > this finalized teardown state is never propagated back to the
> > > individual thread's local replica of the pollfd array.
> > >
> > > Consequently, on the next iteration of the main recording loop,
> > > record__update_evlist_pollfd_from_thread() performs a strict
> > > equivalence check between the core evlist's array and the thread's
> > > localized poll array, detecting that the fd values no longer match.
> > > This causes an immediate -EINVAL abort and a premature teardown.
> > >
> > > Fix the underlying logic within
> > > record__update_evlist_pollfd_from_thread() to sustainably propagate
> > > the finalized teardown statuses (-1) originating from the core evlist
> > > back to the thread's localized poll structure. This correctly
> > > maintains synchronization and entirely prevents the unhandled
> > > index mismatch crashes.
> > >
> > > Additionally, add a unit test that explicitly validates that
> > > fdarray__filter() preserves its invariants regarding
> > > fdarray_flag__nonfilterable items to guard against regressions.
> > >
> > > Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide m=
ulti-threaded sessions")
> > > Assisted-by: Gemini:gemini-3.1-pro
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Sashiko has reviewed this patch and found no issues. It looks great!

Ping. Thanks,
Ian

>
> Random unnecessary comment: v6, v7 and v8 only differ by comments. The
> comments were added to avoid hallucinations in the issues Sashiko was
> seeing; I wasn't seeing the issue internally. This is the first time
> I've encountered this problem.
>
> Thanks,
> Ian
>
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820213757.=
2970316-1-irogers@google.com?part=3D1
> >
