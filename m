Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AA2DECCB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373548; cv=pass; b=YBlfC/WgNjN1HhkYSFkC0+yQsCmRODbhDqIMRmjrH2KkB9esB5CelmzYz18I77ieu3BSx+rcnkrZuqiB+N8MdezmpDM3DhcFfFcG66Ac7+2thxiabeb3TR8vVkW3xsKdqcpu0FLRge9oHPqKkzG3kz9ZY6unpK6TcWI42WYeJtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373548; c=relaxed/simple;
	bh=CIzaUAgiF8J8gX+t2zHPjOu339S6fFDkIyKnYVxmTKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKY3Lp00UuDkkfjvItjOsWas+P1mD1GzAV1oCPZinDKSUO69MxUKzG1DeJzn3c6KUa+b9IseHABPeAYsRBn/mW9JJf/w2pFx/IIPrihz3Hav0PjeN442Swv5d+82Vk0L7WSsAUMFVl23m6NYzN/wONv/LUaVj6WOkVBvu1dh04c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=An6DvNl/; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="An6DvNl/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2591757fbso32075ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 14:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373546; cv=none;
        d=google.com; s=arc-20240605;
        b=MAtJb1EzArqVwYGNr3Ydl+QkjiLBdip47hUcz1XJH8qNM8OH/pMJOB/InvkfITUQxE
         KygTM2kZbpO1iwCt7efYCemyTQylPoDMOZ4UuzIUaxKNn119owYgKA6LdEmJ0OsZpKUR
         0syqPdWW8iHTlcNx6EOC5iXTzNU/aRlpT6BwEkwVWVAzAaG+0ii8QxEy6JFvYqEVmWO+
         rShV1w8/EY+3NOy8NVzd4JzEWALJS8SOpMOzUOBGvrjOBhlLvz21lmPWoDf+z5yZSytO
         h/WpKkkxm6m4Z2pWEsnTaeOL/mOlJS5XMy9x01E7oA3O+L7ckXHc7TAtwTgix3aYtOJK
         jSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t52tkxz7mLmjcwxGZEiWedKnzVb4xsmlZz8mbaNYV9o=;
        fh=BhIpFsDLLQLjvVQAp5E5YC5d5z8aD3kEzd3cNVGWYRM=;
        b=MDNatAhA+jedr1IZynGnaZX4IHTX0t31gy63EARkMskopfsSpadkhcX1gSwSDdYscx
         epDk16I218fR2qUcbYVsG0WkZmjIEwRxtsCR6v7HYW2qSR08Qg2KYbuhEtVHJoNdx4JG
         FGcuQHpaoUVyPw3KGTGV/NANXEokO+V2XMeqpi8G2YciO4Gckk3VC7XDNb4bgYCZBcTp
         FwvSW+JuwbihR8bRjxjhHtxzQeH9S7GzxV9Zs8wu+A82GU9A7svkzKHITwgXHujXqQKj
         Ryn/gFwr5PvPF67JW7asnZc9zC5hczkw9pUViNt17duLK688g71C7oGAsC0975fdS3rp
         9WZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776373546; x=1776978346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t52tkxz7mLmjcwxGZEiWedKnzVb4xsmlZz8mbaNYV9o=;
        b=An6DvNl/gx5B86vxRQ+uGztpo67O/6P1JVZfhZ0ruJyDYIyHRKpZQ33kfOhYBFXoZY
         X51FrOb4mLldh95mLj9FEKNZdmJh5Hy3a9VRES7N/npqsoZHBoYzpfo7qyy7+EDh8n2U
         2EGp1k6Hq/Dqn0w7dVmouTQAgpTIYBPjiMfKaCM7HrQyD4tTtB64styxCLJMGM9ZEDHf
         rKg7knUyIJywcJ5BChQ7l1wTrsJBxGHTkWCs/Z9OFOvnWS1Qiv+QTuk1xTafB3LoiEU6
         Oy5FExTxUqR/rDP2PZ4Eae9FEDlF8E4JZEwZ5dMPwz9sVNbwaFyx9gYJa5/gy/r8YJUa
         ivRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776373546; x=1776978346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t52tkxz7mLmjcwxGZEiWedKnzVb4xsmlZz8mbaNYV9o=;
        b=UKPqpApiOcMgfy2hH/CeH4hjhEYONhd9pgqvt/x90OLfQNY6C6+JNaqWo6/ERKBJ/x
         9llfwgc+OZ8hqClpYRGJWrl3JXYix8w7fhtBesYr/tTfXTFypIKQlOJmIMkz3sJcBvXI
         pdAKN/LcfotXaqBWqWibXsTaK9r+1lAcC+asRqe/8Af+Hit8Ug2ny9trwp019aErDe47
         yce4MMgf1ionSaUV1V6DcLYnBiWPTi9zEgBCiKBPFK2YOQo4LoU4vXyAkgEEtHJlvqlB
         wRNf3FPN3/7Jo0UIq4/Qk1IwT2+5ehfkVLgORTUJmVEaSqUbhmvJkm7byf0fxBb5X4WY
         lPiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nCgDv1xGWsDEibo++gW+oF1dKJeAn5w9WA2+MsTQUJs0i9nNGq97gdRe9R0T2wUH9yl39Jp5PHKyTXCKsNUhL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxmdbpw0g9VP+gbuqGt7wCTaci/t6pdGDQ9frr2CGYNhAVL44b
	d+MVFormYYFACOxHCZtoi4uGyNSv4S7zUHHdWzAgssACXYL3EYjQWlylFK+cXx+8rdJrgagz5Vy
	w+LoL6GZrG44P3pmMON/ANueri2xuW5W1mlLOu5Kg
X-Gm-Gg: AeBDieuH6aa2MG2CqtsiWxwKPf8mlJW1e+hTbOx0DeqsPfLtj4ci1bvfyfe4izyz8T3
	PRvCX+wPO/QpwmaGvfAZaYXEh2kWsRKFmLUyi3NZDbMC9hyaPz+lxV2LYC4cgP7NzreN10vn/xx
	u0FmzyBFyVdSHTTvkrAGz4W88glNA9mw2HfMICg605qww9w2PPtzMAI1MOIDtXMYefLqnSoLsK7
	RsfzjHEu0sFM3UT5CwegeFmGgBTl4lGyI0WJNa0IfRKOSMbj8YH13iG1afXXSWjCPWbSvRL8/N0
	fynvly8/Ygb+fcOX7LoGoNULZIjw/u8H4Efb2EBzzD9/M2rCkCTLDuVb+jk=
X-Received: by 2002:a17:903:46ce:b0:2b0:4d40:ce18 with SMTP id
 d9443c01a7336-2b5f9bec55dmr199185ad.14.1776373546040; Thu, 16 Apr 2026
 14:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416204828.1303734-1-ctshao@google.com>
In-Reply-To: <20260416204828.1303734-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Apr 2026 14:05:34 -0700
X-Gm-Features: AQROBzCO-IdKAVd3AAZfzwmkCMbTDy0gJTENU9HD3W_OjwDEJh3wUoNOQq8qBzc
Message-ID: <CAP-5=fUa9btU_FqtTUH02+CRmVgkudbQ+SA-J=pmNhf0zgq8Rw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Merge CPU maps when merging uncore aliases
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 1:48=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Sockets with event zero counts are hidden in `perf stat --per-socket`
> because alias merging aggregates counts but not CPU maps. This causes
> the display logic to incorrectly skip sockets not present in the leader
> instance's map.
>
> For example, with AMD_UMC:
>   $ cat /sys/bus/event_source/devices/amd_umc*/cpumask
>   0
>   ...
>   128
>   ...
>
>   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0       12                  0      amd_umc/config=3D0xff/
>
>          1.000777829 seconds time elapsed
>
> Merge CPU maps in `evsel__merge_aggr_counters` to ensure the aggregated
> event correctly reflects all underlying PMU instances.
>
> After fix:
>   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0       12                  0      amd_umc/config=3D0xff/
>   S1       12                  0      amd_umc/config=3D0xff/
>
>          1.000666681 seconds time elapsed
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/stat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 14d169e22e8f..d696d217f98d 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -535,6 +535,12 @@ static int evsel__merge_aggr_counters(struct evsel *=
evsel, struct evsel *alias)
>                 aggr_counts_a->run +=3D aggr_counts_b->run;
>         }
>
> +       /*
> +        * Merge the CPU maps so that the display logic (e.g. should_skip=
_zero_counter)
> +        * knows this merged event covers all CPUs from both aliases.
> +        */
> +       perf_cpu_map__merge(&evsel->core.cpus, alias->core.cpus);
> +

Once we have counts, mutating the cpumaps seems wrong; it could impact
other things such as the evlist copies of unioned together cpumaps.
I'm confused by the bug, we should have two aggregate ids one for each
socket. In should_skip_zero_counter it should only skip the zero count
if the counter is not applicable for the counter currently trying to
be printed. Does the display code fail to iterate through all the
counters?

Thanks,
Ian

>         return 0;
>  }
>
> --
> 2.54.0.rc1.555.g9c883467ad-goog
>
