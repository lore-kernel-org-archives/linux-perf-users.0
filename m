Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22653A782D
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001881; cv=pass; b=NXGGulMnKzF0mw2JF02/wlusDjeuMLZk8rf59c7dQTgqK//hFEg0GLJpniXazVZNCa4gOzUne3bEvDjdCMNGSyBXgdCmdNHLpAq7JpfhpjgX5J+00lFaoOxiecpcl81p5GKwpE9Zs/WdPnDwxuoDDcFATwZl/ULxaygTpHn6smc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001881; c=relaxed/simple;
	bh=hUNx1xp5xNrpt5Cuvi18NXUA33NKwpI5g3iSFEDb6Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT0GbnAy8hpKiRQPpHgFmjmlb94oDaQ5NteHk7WVPIzIDZF6Tg/7rM1v3MN8Zkgv6d+B1rYZDq6LawGsYIhb/NtJFFikql608EeaVhdQt31B/uzbY1lc9Xu4topQqqXlK50C2HpIHsX0vqq+Oll8CDTBonwdJGh58vK7oEzrRYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqGMdyd3; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqGMdyd3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so92751cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001877; cv=none;
        d=google.com; s=arc-20260327;
        b=M7MmdE8PWOvMp+qicNIOqLh2uMXgJw/qGeG98ROUu7cGZbFMLTQApNfpuP+VRVxB1z
         bW5d5G3I97GB+O6KbikOmRSCEgNRDc3ipr8T6oZ3AmEDOVbvcBQQgIgfbNe1rQQzlHyo
         44vuKCcHMWHMh6BFJHGrYEnNiUMaRwntHMWZ10RTlWH+Jr2RbpxuMRvodaJfqXpIZGWY
         GEFeleH7C21p8WlhiiMTLKUjuMVnHvkFwukA+1TxhLpMqlGrN8ka1h2/gN6qs+MDt6N/
         Fo1S6YLacGg78YnER2Fmss7sYxuqL1MOApkoutA6Do5/NGlTl5Io+8NnXLJvji08/lvw
         8fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AtlkQsWpD0HNfP15aHmIslFycbm66FyPMjzRdcH37g=;
        fh=ibETsmvSSxOWW4enplhKXGlYpux9EMz7KKg/MqaWdc4=;
        b=lGy+fhXR7uXpXNcSIyj/uvvclYSc7rio+8lbJb6VCUeD54GfywUTz1R600TjJBLwqH
         c0PylwfZB83WLi6CTAyzS0GgkT6HieXZiwdyV+IpofNE1BvwuzhWFlmYn4RcUD6eN2ac
         XL6j3NjX4h2Zo0doc4A4E/bENd9loTezUKUfQR96SiFkHW8SYJxc/h/Zdj1uYX/9NBZ1
         b7XXghXLAJcVIW6qzcq0N0e0xkohoVUtBi9XsaK5Bqvlwn78WLZxmXIdpWy5zHg6m/AL
         tV/8z32rZvZkPXjJlxM7yQdNt5jWe2G+/2T+biFokIUXzftmOVT5kqywfAMOmHZ8DLhW
         5uqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001877; x=1787606677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AtlkQsWpD0HNfP15aHmIslFycbm66FyPMjzRdcH37g=;
        b=EqGMdyd3hebAReygVz4c6DLoGsj19fYS6NoPDEQfcexUK5TbbqBmuNunmdTr7Lfz+j
         QkXQ1kBmn2xtk5W/pm2e+8L9uF9UOvIjDuEqhUwKhwbHLPnQgY9xbd9eHnw9T7DiI2hb
         69KOxBymjxk66QUwG+Pf1P5bzeLHhTg7hwiPbjRa9mT28kK2v10SqJ62uE5UGme9r2BX
         Z8eNnTUYfTT5/pzFofy3ZarSfZFWaZoeA792C/zMaabD2HeyciEvbcD4ZudweI+VmZM2
         cED4mIo478g+Cf0HzEDrVOwTluRxKeL3MSf6hcbS/QR31ZK3XT14IB4j0NEJ3a4P4eZP
         sT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001877; x=1787606677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AtlkQsWpD0HNfP15aHmIslFycbm66FyPMjzRdcH37g=;
        b=PbXqfIJ/4/EAuBzVo/Ic0DHOUeUVlDE81uG0RfGy74jgqhKtUCy3a/bI/WmR/ZXE+b
         PbmkfFA/Sp0qMeffn1N70L6R0fJ7OlQ5jR3fbh1qEHE6uqmfmwc+p7yiK9gLOEQLjkMs
         aEVI2xPOrqk5McqJ4JpaO0FcgTQZFWpSLemoxFNO/WTDTkIVVyLcSIL9etkY6NTj/GGB
         6Ms+bQI2RBi7QLeEcXCfdoFCrCIsZjhdwfmEyrbYTeT4+1mTKB5x1V7UOv4MzMYOBlye
         Sg9mEQNh194l2AZGCZ5UlOLrDxo8Gr11j+5x1rOctBM9DozT5N5yZ3I8OUsxIMmjZrt5
         Acrw==
X-Forwarded-Encrypted: i=1; AHgh+RqlQ2QXiuEn/AQLtZ2AiXJv9Gs8vEy5fVDnrJ9L1jwp6ZtHbyDJA5ayRHHoSDf5DYQcptAk+3/4SHc3WqEI6xnO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9T3lW9ayEB7wgvMlWaMFgu2gzi7Oh4Tb+vH51HB+l3VsX5XN
	mJOR7VFJbY+0qK4Lqj8LbEH4rRyPbcZDamQbPF8aNli/Oja/2RNkIFIhXD6xH77qG/d5KUcu2fK
	TTiFHq2ZJwEeKu6EMsL6ZIGgV4Fz3NjbNHUGFVDQt
X-Gm-Gg: AR+sD11j+moqG9CWHMrkjG3MQtX6s9sI/y0BBSNo2KPHJsdvJ9dmBgp9Mphww6ewBoS
	/1uinmNi4KUx7H+afIbuv74r7HFcg+ePvH0tpOgSYjwJRf9ahIBttv+DnWA0leUPy5i9Xh1GNP6
	fbqC9P2bivxuDbRz9m/0yxNgpR4auDezacgCdtvUaEg+yrKBLC+b55SCVVZOEHXBbim9bUpo7MC
	4pL/NMcnBrqLbySPqNWy9GQASsZiSv4h7Q0ibEj95h1HIhCNeWJwOpAztiaS8Dv+8aL8xUUOai6
	db6j3Tk+rMK1z2yWJ6dIdhbRb2yrpPTCn4oaEaCbc4T36m0EqJhzY7aTtIAQ8AVNe+DIY4rh3OI
	=
X-Received: by 2002:a05:622a:4107:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52dc4707fa9mr65951cf.1.1787001876802; Mon, 17 Aug 2026 14:24:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-2-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-2-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:24:25 -0700
X-Gm-Features: AcwNN1XsOa8yk1nfr1DOaKCnCIer7hz8NYO8ZDOHs4KHocMbo0cA77eoSvQgygU
Message-ID: <CAP-5=fVbwxLMryUOd=HOqZapJF4c6HCSMSh+VTVppAfwk36myw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:33=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> When printing memory info in perf script, the entire size of the
> buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
> size. Pass the remaining buffer size instead.
>
> This issue was detected by sashiko during an internal code review.
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/mem-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fc..4e490f9cd348 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>         i +=3D scnprintf(out, sz, "|OP ");
>         i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>         i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -       i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +       i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
>         i +=3D scnprintf(out + i, sz - i, "|SNP ");
>         i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>         i +=3D scnprintf(out + i, sz - i, "|TLB ");
> --
> 2.55.0
>
