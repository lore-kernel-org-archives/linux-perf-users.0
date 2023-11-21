Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89568110;
	Tue, 21 Nov 2023 10:57:29 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so49423a12.1;
        Tue, 21 Nov 2023 10:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700593049; x=1701197849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7nd5iX6ZJEmZiKwOnTC252kYXXi23G070RiX705xqE=;
        b=wB9/ElwECpCX7dGZJ5a2L0IXpia31OvL3/fUQ7q0Amcj6AKr445vnDG1Xg4xer0Ttb
         qs9zxi20l9S5prIvp1kk4gyQROn1y14du7bdfKznVVUo8bP7ptEuTNb2/oHVhqOjdw8c
         HgdoNOX2aTCYlfNCXTGROPTbASI/GgFVJRMipnvIFtCnkPAWV9ePVEx4E6d7b2bzlWuG
         tOePTQSMisWt1HaRa8b+otgJthfYmq44kMb/snHy2zvWieiQu+D3onlFwIvRt7/AjHC8
         Qnz6tBI7TSo1tQRVqF1918VJ3xhkFWIBt7dYsPVUnGrXwiN6xBD8AVfYlGnQJUpLXw9i
         7x2A==
X-Gm-Message-State: AOJu0YyRvYSvKQ8BhsLKmz70KiMzmNFc0Sy/r7ybxSSgF9s8WpEs45fi
	FMNCATB5RB0HhF8Y95YJpHdGDQreoZmnC1RTFwI=
X-Google-Smtp-Source: AGHT+IFuNxznNK2HJRa7VA1pE8Svesap4SN7xD+x4Dhimb/KuqtOjdJ+q0k7CEtYwL1GcfcA0qiJMB1qHBB1WFjvwmw=
X-Received: by 2002:a17:90b:4d8d:b0:27c:ecec:8854 with SMTP id
 oj13-20020a17090b4d8d00b0027cecec8854mr406468pjb.7.1700593048898; Tue, 21 Nov
 2023 10:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118024858.1567039-1-yangjihong1@huawei.com> <20231118024858.1567039-4-yangjihong1@huawei.com>
In-Reply-To: <20231118024858.1567039-4-yangjihong1@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 21 Nov 2023 10:57:17 -0800
Message-ID: <CAM9d7ciAcjjncBEbA0zAoyThQUwJbeNHXuTX9mEWzUcS4FbLew@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf bench sched-seccomp-notify: Fix __NR_seccomp
 undeclared build error on i386
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, avagin@google.com, 
	daniel.diaz@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 17, 2023 at 6:51=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Fix a build error on i386 system:
>
> bench/sched-seccomp-notify.c: In function 'seccomp':
> bench/sched-seccomp-notify.c:46:17: error: '__NR_seccomp' undeclared (fir=
st use in this function); did you mean 'seccomp'?
>   return syscall(__NR_seccomp, op, flags, args);
>                  ^~~~~~~~~~~~
>                  seccomp
> bench/sched-seccomp-notify.c:46:17: note: each undeclared identifier is r=
eported only once for each function it appears in
> bench/sched-seccomp-notify.c:47:1: error: control reaches end of non-void=
 function [-Werror=3Dreturn-type]
>  }
>  ^
> cc1: all warnings being treated as errors
>
> Fixes: 7d5cb68af638 ("perf/benchmark: add a new benchmark for seccom_unot=
ify")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

This is already fixed by:
  https://lore.kernel.org/all/20231017083019.31733-1-jirislaby@kernel.org/

Thanks,
Namhyung


> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86=
/include/uapi/asm/unistd_32.h
> index 4798f9d18fe8..9de35df1afc3 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -26,6 +26,6 @@
>  #ifndef __NR_setns
>  #define __NR_setns 346
>  #endif
> -#ifdef __NR_seccomp
> +#ifndef __NR_seccomp
>  #define __NR_seccomp 354
>  #endif
> --
> 2.34.1
>
