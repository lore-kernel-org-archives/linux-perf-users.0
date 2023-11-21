Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC003114;
	Mon, 20 Nov 2023 21:24:50 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b2018a11efso5312795b3a.0;
        Mon, 20 Nov 2023 21:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700544290; x=1701149090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbLdMusjW0dCDLki79+7/JUBcA8NhZaK9rFsYs17SeI=;
        b=qT5qXqrYJUC2gzc52MRrb/2rtPDvB9aZKjhYKksvpWaFsutZBml9z4zC0+2fS1gLCy
         eHlroyL4QC7NOjlyCmwtn9HUm5MBNSBl9mHb8PijUw9/d3bHZ8usPzP7uQr6LBGDp34x
         gdhxHR2rtv7DutU7xvTdkCFcZiLNMynhK50yrqusD604WP7aPwxLlH96dKgaWDZcOaQs
         6UpS1dG+B25Zln3YXHz9YoBZJEklPHf+0qhlzxl0GERGIwy1MNv5Usk+nezrH51FQPXH
         XnmKAVqkPUpRVvaVW4rhlawKZM0L+aBXxbZlCr4amljnhQji9Va8FDXc5hOD4AyLQgNZ
         IJvw==
X-Gm-Message-State: AOJu0YxRKkoRv5TgzCQQRhsPkJ8xk9NwNGShiEgJbhN0SKthGQ1pFj+m
	WfK8+xLP9CUYc7gx/qCJm5Hn8rVMLpOGojYFTNM=
X-Google-Smtp-Source: AGHT+IGjthLnPzOEu3tXzrhoEQ6rhUZr2Yv0K/uWaKPJYurAqUlfEbr9BMk/qZrkg5nb5lpP7F0qVRe0CTlaQNLmoQ8=
X-Received: by 2002:a05:6a20:42a7:b0:18a:e21e:51a9 with SMTP id
 o39-20020a056a2042a700b0018ae21e51a9mr982953pzj.60.1700544290299; Mon, 20 Nov
 2023 21:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118024858.1567039-1-yangjihong1@huawei.com>
In-Reply-To: <20231118024858.1567039-1-yangjihong1@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 20 Nov 2023 21:24:39 -0800
Message-ID: <CAM9d7cgGWKj1T6-cjntHvMDgTkVKzNQFPWW8BxQwRKChJdpniw@mail.gmail.com>
Subject: Re: [PATCH 0/3] A few fixes for i386 build errors
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
> Yang Jihong (3):
>   perf kwork: Fix a build error on 32-bit
>   perf lock contention: Fix a build error on 32-bit
>   perf bench sched-seccomp-notify: Fix __NR_seccomp undeclared build
>     error on i386

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the fix!
Namhyung

>
>  tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
>  tools/perf/builtin-kwork.c                  | 2 +-
>  tools/perf/util/bpf_lock_contention.c       | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
