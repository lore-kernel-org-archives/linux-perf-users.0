Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34593290AF
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975903; cv=pass; b=Hal1imMLEtVa4rQbrLQE1SRWX5E53RCp9AFmvpcnuxyQsBs0jxFzlvZdfTDj6e1mQnn2lM0S4mNSafBoCi/1zKLaXWoS1f5hp2+RC9kAO8sUu9bUbPOCE3wzyYQgjcNgsEhRc3m25jiTo1HM6SXxoZPYzH9RFeUwFVbfbCzZGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975903; c=relaxed/simple;
	bh=YGiYOD0YAzl+hsyWx9dTJVp1iE6LcM1LkEa/CRJ0Etw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZH/Krupc6vfiAOTaIZMMAuxoKiK9irpdwIuIG4tdpPGUQmuHxqi0OnkDyKWfvG0iFkAFDzav+Wf8kxVvxp7Q5vkM9xoRVaE508TWboeTNdrZ+illEMhC+7Vb9DkOEOljthEdcJ7+XJovLkkd3Rkk1kB2bO8kqKg3CvnEQH+E9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c34eD6uz; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c34eD6uz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b243198058so174695ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 13:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776975902; cv=none;
        d=google.com; s=arc-20240605;
        b=Wpkt1P96KIVOcsykul9e9ZIHBh25AAU4Pw2obN4POv9ojwBkdu4FaKPbGg2jMtYksB
         aveUicZV5MnJgGClWZYArRwEALoFfs0dAnHosn7VkZTVTg6hGC/CRYo6LPau5UIVq0Vx
         oAle+o0eyKrFWnvmcVUaJfiowkczdF8T1AM+Mv60WpmQbxnTJ7LUbcQi6JynslsNB5tu
         FC/xeDdisGADGst46BbonHHQs5GcgcbA/9c0HiUTBgGLTV+XnmT5MyEVfErDCLbwsHji
         Iu2KXMdzZY7aRu+EqbPECp0o7UYb0LPwS1ZBFbNV993f73M7uZB1TQWrR7/yeoJHhbY9
         KRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0weOdPezfYlqgB68Vq6bqWqObdSULkcZsBLL+kU61o=;
        fh=JF1brwAazhoYdt7RQ1/uhQpUYSUqQ76BdI0HNBqF12M=;
        b=D+/3LCdSKxYuDtXJW2Qgh0q21XTkXSgbG4AhU2YtWpIU7BetujJzxlpwltzXtCsBGh
         txB3BCZUQiSW1EN9tlDhs75V2ZJjG2aBj2+5mQN1DQMVfbKh5UXYy7532igtHzsYZTX1
         zxh4JgFFvj0clxT7MCi/4mSbeDh6m09AUXex3tOmkMv7BOCsY51miXxtbvUTC7qsx4EL
         Rc533fpxylTOLP9ltx656C7u7ZdZaBWrbJZMgtMYijavwYLzLyh1gE3DgQz9gcrS7IRE
         t99D1g1+GawQ/RYl9llNQ8jvMcxF/QOEqiccG4+eWI5eStLOURZX+oMKT6xTJ8G820LV
         TdSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776975902; x=1777580702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0weOdPezfYlqgB68Vq6bqWqObdSULkcZsBLL+kU61o=;
        b=c34eD6uzDYWAgVzpuIzZmUAjwgNzB7UzSxrEr35YA86ymikIj2A61YeF/YS5KYcOES
         LYgwBdubYEcsKXAB/aFlXJA8Pakbye8di0prJuUwMkPo94+ePKffo1Tvgjyg7fo4BuiC
         uU5/O4cmawHeewoU/EXmg+07hBM027ktOGVn7Lfqhbf5xJuzGMPWEXzsSzNOy8HRpyWZ
         HQEQU9GiF5COuTlnHVEEP4jZ2L6/RnA0wvPCdOFDdnxn1V3P0JXKd5qoT+rQWpGXQ5qm
         P9gccXBUYZL2xHsthPXo3Y/HX186yccY6Qy/OnMjDH5y8JcCpLju6nNownFkr8SRk/66
         E/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975902; x=1777580702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0weOdPezfYlqgB68Vq6bqWqObdSULkcZsBLL+kU61o=;
        b=jcuSGbpJ5Uwf5dC2TnzO6LIhsWDbeT/PEbjdp4Jd8vHKIewnr3gvDpiTvDsdJRjj6f
         5i3LUZrIzY/NdRRrC7NFbEGZT7pLoZ+Jk0gYEzyAANE2bkFovg0/zCWprYMkf7vNA8rA
         t/SACGijzdJBg+GwqycP0LYhgT9K5kV1PF7LKMuPkSKH6VYYRkUSmGwPyZlaGvk9GOkj
         7d8wcvLZVuMcIzqhgEuIFqZ6tmReNW4jFWq3vWF3TlfgAUSfBLPCx5LM/LRahD/UTwOY
         6UIhJjRj9cKjJj/u3g6E6hrDWuJldEEM2Pw+3XWbfhxn8qiqO+iwkDhVWT5U1IDUTGxy
         aaOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1CRbzvvMWUuFKBjTgmC3C2OhdmqNfananJI206GD9zcdUEOL1+AJJltrCdnnV1Ze2/L97/STzYoXJfad8ERTR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pqFDBDPtIMqSIdTEp2p/xdeyPMC3lsuMYy9QCBMUNFKGMaoW
	WUs6/XhQBhoU9k+lg1Y8n2bTQBfcg2H+ulshJwXo6N9f2QOD6ZEZWFXQjIzbDolEri85NHGbBGV
	HoqPWIRqvkxEGnvvSRlSqAtPNZXzqwO0eYD4z2PX5
X-Gm-Gg: AeBDieu2nxlWdiuY0VuA6cyvuwcajnd4vL6z09R9Ggc3RJQiRckXVDBbrJhEob9w2iI
	7sxgcF1qTEA3UcxezeqzX2E2C5YYBD88D0tEoLDGr7GfqjRPkpnQwyRKl4XUlAPZAp7CeB3RYSa
	p5sjIudbsvyr6PvZl33mn70kpuu07zQlP7y01Qxeoqp4MMbUdq2OzjhQIYw2i9c+7XSK3mpkoDu
	ldI5rEPp2eIg9vD6xXHt/ihXKcHXwPJnSt8YWoCuY0ZqpjlgpicTFdtqg855aUGS7F4Blrq49vy
	RXu1XbcXsDiAgpYsfTx7g6jU0wQHbpqV1ukOclFEOWpysiauHuYtIUHWWg==
X-Received: by 2002:a17:903:2c0e:b0:2ae:4808:bd99 with SMTP id
 d9443c01a7336-2b602f29c57mr8502145ad.2.1776975901690; Thu, 23 Apr 2026
 13:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aenFGy9WDllTEO0S@stanley.mountain>
In-Reply-To: <aenFGy9WDllTEO0S@stanley.mountain>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Apr 2026 13:24:50 -0700
X-Gm-Features: AQROBzCiRPLfxkESftY2EeWvuWdseSpvfvpTBkOMFLmTqI9Jr_bU2OjbTiN_tw0
Message-ID: <CAP-5=fVL_qishriDrRvvXQQ5VSBZAxs3F-HQ69yEtEzdf+6MMg@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
To: Dan Carpenter <error27@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Guo Ren <guoren@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:07=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> Change the > comparison to >=3D to prevent an out of bounds access of
> the dwarf_s390_regnums[] array.
>
> Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF register nu=
mber mapping functions")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/pe=
rf/util/dwarf-regs-arch/dwarf-regs-s390.c
> index 310a37451bdc..f79216a7665a 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> @@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_re=
gnum)
>         if (perf_regnum =3D=3D 0)
>                 return 0;
>
> -       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_=
regnums) ||
> +       if (perf_regnum <  0 || perf_regnum >=3D (int)ARRAY_SIZE(dwarf_s3=
90_regnums) ||

It looks like this mistake was copy-pasted into these files as well:
 - tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
 - tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
 - tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c

Could you fix them all?

Thanks,
Ian

>             dwarf_s390_regnums[perf_regnum] =3D=3D 0)
>                 return -ENOENT;
>
> --
> 2.53.0
>
