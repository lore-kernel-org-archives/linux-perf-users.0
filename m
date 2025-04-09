Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679726ACD
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240793; cv=none; b=rHCr4wNEJ24J3QGXGDL4Ism7Gjw2HdmKungyh3Vr9lvA1orgyu1mzgcNR3dL1LBtQv/01jHGSZKr0J8TkJi62nxM+uM+ddhF4qH1IzWmH3DFah5zUe0V/aNYAL0AWimRoPY6oGT2Jb5KNFDxtDodfLKkT9TM2E9EXAq6Q88sHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240793; c=relaxed/simple;
	bh=71hAWHLiFpD+a5jiSITIHN18+maVag64lop9nMHtm78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJyewQ8Ked0RIxgF2br4UdeTlEhdWL5EpZLEw1SXUFQjizJ0drfjeDq5ZAgf+rmcjYmnDYIwd6IwMhZ2WMv6IoNVfWclSJmee4uFEEM3DXBy5wx0nlsaIq9kSVc8qf0m+edd2H4ofWaRLEJTt1ag8pQbGCtF3iEnlsWa3ihKSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmNYvHMR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmNYvHMR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so40253066b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744240789; x=1744845589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKWaFZk43rgDH26fhayoqoYl3AbcFzAPS8RRVE3yeKQ=;
        b=VmNYvHMRIj/4n0Z2dQppGqTLwRz+anIdUr1GqU3mOMEFqqC+VvjX+PqiGoIhD/17Yh
         KApRRtWNRusBOKLjgd75pTmy8ITSZJeR7zbSPRpqVBa9jjzZESLVLFJae6gqZIS4dyZz
         hZ7vqQSrXN/sltB0kxr21pCE0ThEzLc7+0zD3GiLrSg2id2r7uNVhIoS716UqE+aX0rh
         wWJHNvXQ0qSSDkBEPO7RfFwm5B1MJPMEFmQgiIpS01CLi1k6TyO2i4aciVaQmbpvwK1I
         4hmeeaI9/7I/DitrPZSMI2BvQ48eRcOAF+qL+PVVdkFDHkyN6sGB2sIYg7ey04FDLJwy
         Y/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744240789; x=1744845589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKWaFZk43rgDH26fhayoqoYl3AbcFzAPS8RRVE3yeKQ=;
        b=o3X1lOQ39M/l6UQEiNLG8fszpAhpWEMGK4TbeBGaEXebovrFN7TpCSNqrHb2rT5fDU
         1TFr4v2REbtI6hVbq0BQDfZGIR9hqKyO/K4U18uHGMetOuL3iQtt8gAwi5SA41VOaF0p
         WwWIt8jvNzjsZNGku9/Pmd/eyMowaFhJGXlTHiSAc4BWNpSfXgTzK+4Hig0Ztb8dz+jP
         9mfMcsqt3jeSQgMqfc9A4GL9JIZ9uYrw6oS/udGcnKdxHHHtOekSSGbeQxyJvxeEd8WO
         d+omgLb3zNl1xeWcM/c+Ps6eXezvTZS93O4DuD7Mg4444F3UfrUpDb8vRc2mTUO57Zhc
         Mc0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+5QeczZ0jFMC4mBMy35SMcxam9Qnh3VYz6PETdhgaQ1BkHEHhNKEJLkoDUqCD4n5X/rEkwV1ndv8chZNVrUxV@vger.kernel.org
X-Gm-Message-State: AOJu0YxiT3NeREYDnlQC+OFQLrMdnCEhd0jypxn2g+cuj/LmijLwi7Jj
	wtaw9a6owhJZIDNNC2U4J2MTKQ8cqE6IAyM+1JlldsSatHP2EDYfNeix7A+jDGIyGpd64pvS9mE
	LlgKV/4dI7PkK+qWVrLB2I9Wmz+IkthSEKJpv
X-Gm-Gg: ASbGncv2tEe/BomecRsvX7aSgbpYjiJ1avIElQWHI1cgZKsdea+RXUUrZHFIxQqCp68
	gWeNajTZprAzy3igiu7F+gfN6M+uj0mf8j5ROCFQa8eW4CEizhPC+i3IfInzJxmguPBYWijF2qT
	08WxyBjGscGU8UNG8D4vuRQJR/wcuCJF5RUopUIR9nSDMZQibmiA==
X-Google-Smtp-Source: AGHT+IH3H9hon9fi6gr+1QyDX4U/GLkhh9rGTxVKKUyWAl54d3JklF542TjzmmO34wBwGTSeDQ0l4UcIIVY3pDFbHo0=
X-Received: by 2002:a17:907:7d9f:b0:ac1:f003:be08 with SMTP id
 a640c23a62f3a-acabd123b41mr38723666b.12.1744240789447; Wed, 09 Apr 2025
 16:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409231230.1678358-1-ctshao@google.com>
In-Reply-To: <20250409231230.1678358-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 9 Apr 2025 16:19:38 -0700
X-Gm-Features: ATxdqUG7u8AhjXxuimcJvGUI979Ts_QmPqbpXiKuZoTa2MiVtS4-QYZRwMc_m5I
Message-ID: <CAJpZYjUCwZDDL-19nGwZNgo1X9o3sTJoL2NeR__CxrTXTB4V4Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Allow tolerance for leader sampling test
To: linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, dapeng1.mi@linux.intel.com, 
	vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this since Thomas Richter already submitted the fix [1]
with bc invocation.

[1] lore.kernel.org/20250408074641.1471473-1-tmricht@linux.ibm.com/

Thanks,
CT

On Wed, Apr 9, 2025 at 4:12=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> There is a known issue that the leader sampling is inconsistent, since
> throttle only affect leader, not the slave. The detail is in [1]. To
> maintain test coverage, this patch sets a tolerance rate of 80% to
> accommodate the throttled samples and prevent test failures due to
> throttling.
>
> [1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index ba8d873d3ca7..06a718e80121 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -240,19 +240,39 @@ test_leader_sampling() {
>    fi
>    index=3D0
>    perf script -i "${perfdata}" > $script_output
> +  # Check if the two instruction counts are equal in each record.
> +  # However, the throttling code doesn't consider event grouping. During=
 throttling, only the
> +  # leader is stopped, causing the slave's counts significantly higher. =
To temporarily solve this,
> +  # let's set the tolerance rate to 80%.
> +  # TODO: Revert the code for tolerance once the throttling mechanism is=
 fixed.
> +  valid_counts=3D0
> +  invalid_counts=3D0
> +  tolerance_rate=3D0.8
>    while IFS=3D read -r line
>    do
> -    # Check if the two instruction counts are equal in each record
>      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"cyc=
les:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
>      then
> -      echo "Leader sampling [Failed inconsistent cycles count]"
> -      err=3D1
> -      return
> +      invalid_counts=3D$(($invalid_counts+1))
> +    else
> +      valid_counts=3D$(($valid_counts+1))
>      fi
>      index=3D$(($index+1))
>      prev_cycles=3D$cycles
>    done < $script_output
> +  total_counts=3D$(bc <<< "$invalid_counts+$valid_counts")
> +  if (( $(bc <<< "$total_counts <=3D 0") ))
> +  then
> +      echo "Leader sampling [No sample generated]"
> +      err=3D1
> +      return
> +  fi
> +  if (( $(bc <<< "scale=3D3; $invalid_counts/$total_counts > 1-$toleranc=
e_rate") ))
> +  then
> +      echo "Leader sampling [Failed inconsistent cycles count]"
> +      err=3D1
> +      return
> +  fi
>    echo "Basic leader sampling test [Success]"
>  }
>
> --
> 2.49.0.504.g3bcea36a83-goog
>
