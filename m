Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA14483AF
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500944; cv=pass; b=LMx/HO+QFWML3wohZ3oa2Ar1mZwRsy3cr+eQKcP+6mOZlj3NV3VrM0viQ+xvgQY3AEZJs0ELAtEMsIo7VrVDrZ1KiwgMwZGEduAMDXcLzY3PcF2ykQ6DcFWdAv1SG5L8OKRABdJERrPLlOaSLjIgv+0hz2Nzi9UABdV3B+jm+ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500944; c=relaxed/simple;
	bh=EegVME3jJbuQHyWc1V01y8Y0UN52nI5cYIfZ+hwBI+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbjBuey4oVlTngumJE3sDd93UFCXV+KWgYLC6m3O50RWczBaTTUfPaLW9nTuR+ooTjrU6Gktx0m4CHcT4OlVWDxQeaA7CJ84bjRR9veF/6prF4bxvg9W9gHtCqOrfMhhcyD60htxCfmQIorPtW9fDbM5VhIf32qqJD/pbY3wZQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5Jv4Gtu; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5Jv4Gtu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so65831cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500940; cv=none;
        d=google.com; s=arc-20260327;
        b=iYCmMYlFKTLu5ujqai6GIO8+48hHXgaeKMTThPkilGWcXheesheHWv+GzMoQOtXqoE
         AnqnyqJNbRUPPnYpqLLWB2JlL8ZiZOFcYOitGFr5d2epLA4FJAjzarzI47gtsVGz+xlo
         3ef1xJR+brozRgloB+NUhTWFPFH5znNmJHqAE58h+J4oPyNg7PjM5yIgJNY69o2IwY3h
         JmqKT8M8F2g/HJsHYxsxjY0chxt1aVGKrlk9vMqzVE5kKsurvIHqd7KNaGeBJNVua9Xk
         nZV442PY+RUSgTtB6fH0iiVwQd5ixiPP4xqPv0HzfAg/jGjg9w0R54dz3PUR4ri1dZq/
         v/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cJfPpkkLfvSAtU67yJNBlNgv9fTffV7M0TlsnD4pBA=;
        fh=sJIKbMLXCxajv7tF+fHTLBFEmaDg0OaX9sKYNALUO4E=;
        b=Frnr6fxZCmL7F+r45CjtH6Rgd4Kr9Gd2HgyKqSTthKlOtWe0PR8elEVMdSVWqQAIw5
         OzoUXXLW12g+ZqhDYlhxsxz+bxiAQBE2AnCE2qgZRCAJqnBzyb1zE5DIHAvGSWOjFsOO
         IgTTloGxiOwLWR7BhPiRxpDvEdjRZgDo15DkZWO9LiQtl4BqlpfpW7FLcoLLziQ2HWfx
         m9atUz1qCmxScuoYExr1bJGsiAT92hEnSqIRtijtfXTedTW5Xy1tukFktGo/25VXm4vl
         ckG1aY58Qju5nfPaUUoL0JUVTx7/qBIhZoIOui6lwo4orN9f27jejEH7KREbh9KPwjSa
         r+Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789500940; x=1790105740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cJfPpkkLfvSAtU67yJNBlNgv9fTffV7M0TlsnD4pBA=;
        b=Q5Jv4GtumdJivcRpn6mfBG789g59EgPhf9q8OxQUt17afAGPB8SnlUCJbRV9Kjtb8o
         Ut6L3466S5MQl7NGPHjW9x+Y3YfNQu1CcUmQaA3G4QMw50aJuyd/5hpWVYoxf4a3SxYE
         RtgqQz6LY1G0u7RnIgcNfTc7yyyMUcVHT3F6DeYuE+ZmUUc+GKdx1iMeYweBp+yQ7M+L
         BBK3q1yMGGeJz/GCIXzLbV0Ioh8afyAMpxvFQR41sSIQUjZ13LJTH7sgb8CzxPLAPniP
         7K9etsJ3c4oUc98qQubUMMQ7Q84mApTof4S+0bYiJPnZNyE31QqJqq4hkynHkk0S93Qy
         mdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500940; x=1790105740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cJfPpkkLfvSAtU67yJNBlNgv9fTffV7M0TlsnD4pBA=;
        b=C8l/RJPd5SqD/3+O15V9A6e8ZF4+1s+00AJZ5QDcxXYCIb5OQ+sanKEZRVX+iQtdgp
         /HAHuGF8KuoUDPTKtrIJN/LjmxFuwYjYY4/IKb8Dz9CUs2z1pzLifZJNxB9wf3ZOnQ8O
         xaL+9b4ti37w+EVrlFMX04tiUJd+FLQ3Z7MAQngXlO1Ib79XN721FJlIhCzDakoClwAn
         wgTOcjKW7mC2OquzWh5rXmVe4lpKTVwF9+ENVqviERqs2M3ofwFjks+4bVr8S3o6ELkp
         Ipg0qV2+p/E19xPM62T+L9CwMyvKnQJY62G4Z3mTsMeYdhJF4HO7mYBh8N+UMWclco8b
         IbsA==
X-Forwarded-Encrypted: i=1; AKwUvBzC6f+txs2e2NklRpzauKnrlfI/sN6tSBQwap2CDcYW+ieKKYMresxWCvbE4D2IWMu17Tv2LPTVXqkdUDDrQ5O1@vger.kernel.org
X-Gm-Message-State: AFuF++nS7efIMoPwEGLHRDFAn8UN79L8j+nhUx2Bx+u9d0GE6Z0WaygE
	xRpcESDd72xcKYbAvC6qZ7lcvZJrlLenMjXf+LSpz0KnDzRe+ftOrUrME7eQM2+BCa2sv2tojDF
	OsEFYDe9O5lC4IqOCkFjTK+BoktN3DT9FuGflgHI7
X-Gm-Gg: AYBFou1h6ucngjAF9LxI3lO1ws8mO+DyPq+DK8bOeRyA01Pz3zeuS3iC4gfRm7GPKFQ
	lBXum9/lCVkhBQmjkf0OF2KOV7xsj9gHDwLowjDz62nTBGry43AAOT/FksmnGz6n1WGmRcvZvEY
	bbUHbgLRM97QH08zkEIPYaMBL8KFxgeHMwqC8CuYbMH43U6rqTAYq4dMsAfDjjKlQwzSLMJwGEB
	uskrQupukEWZtPzhnWEdDGGu/nMJpXHUrw8LQGA6Tm/9Obu0cwEa9QI5gleIh2UKeXMAboz8ZTv
	IBNKIa5YwqL30ZQTDK+U6+R95+0/n8FIdSc32D8fKyVOxH8+/nEuuJXoUOwTEZESkoiRXQLw4A3
	ZUri4TTth9A==
X-Received: by 2002:a05:622a:1a93:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-532583a627amr3002591cf.14.1789500935305; Tue, 15 Sep 2026
 12:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914121903.1212-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260914121903.1212-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:35:23 -0700
X-Gm-Features: AcwNN1VYoT5oxIlcFTffUxjtkWkLWpHOZQGEahUpqwEycg875lihiCow5XKgF3M
Message-ID: <CAP-5=fVW6nJXoh8qf4e_jkLXGUzCGCTCg9YivHkN9kkVJmMa-A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix a leaked map reference in the arch dwarf
 unwind tests
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:19=E2=80=AFAM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> maps__find() has returned a reference to the map it finds since
> commit 42fd623b58db ("perf maps: Get map before returning in
> maps__find"), which updated arch/x86/tests/dwarf-unwind.c but missed
> the arm, arm64 and powerpc copies. Release the map after reading its
> end, as x86 does. All other callers of maps__find() already release
> what they get.
>
> Fixes: 42fd623b58db ("perf maps: Get map before returning in maps__find")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm/tests/dwarf-unwind.c     | 1 +
>  tools/perf/arch/arm64/tests/dwarf-unwind.c   | 1 +
>  tools/perf/arch/powerpc/tests/dwarf-unwind.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/a=
rm/tests/dwarf-unwind.c
> index f421910e0709..d4707e9ffd2a 100644
> --- a/tools/perf/arch/arm/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
> @@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
>         }
>
>         stack_size =3D map__end(map) - sp;
> +       map__put(map);
>         stack_size =3D stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
>
>         memcpy(buf, (void *) sp, stack_size);
> diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch=
/arm64/tests/dwarf-unwind.c
> index 440d00f0de14..fbc161a49369 100644
> --- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> @@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
>         }
>
>         stack_size =3D map__end(map) - sp;
> +       map__put(map);
>         stack_size =3D stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
>
>         memcpy(buf, (void *) sp, stack_size);
> diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/ar=
ch/powerpc/tests/dwarf-unwind.c
> index 66af884baa66..b4bade5d59e2 100644
> --- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> @@ -34,6 +34,7 @@ static int sample_ustack(struct perf_sample *sample,
>         }
>
>         stack_size =3D map__end(map) - sp;
> +       map__put(map);
>         stack_size =3D stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
>
>         memcpy(buf, (void *) sp, stack_size);
> --
> 2.50.1
>
