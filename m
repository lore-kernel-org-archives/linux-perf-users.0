Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdOxlM7R"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6445710D4
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc79f73e58so153615ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701260507; x=1701865307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=bdOxlM7RAmZg1OpHSkxKL864stOnjSKxyFqjmE/WlnPxNyFC7g42HGDP4cMHYkLffb
         0k4QxcxvxbTlEzyGKHtnI+7gZJ5wLKDoXq8yp0ULCcvGL47hz56N3MfVhE8eB3xGeKJD
         qYy2dYDFb5y3Eusd1ekO/5foZ6rK0zLcJ0I+7K7beTdw66aCpcHpLMYXZq3eOAg1Oh7C
         fhzemgMWrOYv/k+80Zd4SciI6Rm+zPCRjNFhTbkNRJqbigzsBta1OE8JsV4pyZhXimEa
         sOUpFpflN/YTWIj7K0w35aD3lYXPlVvSjFKPuy+l2NnHOIX40CJ1OEut/F+ImBS0aqjl
         n7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260507; x=1701865307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=s0Ygi0tMVss+CphFMUYw5NRYaaXkhLJrFeIBhrMd1opp0tvKij+SxjfX+0EcKpKc70
         /9A/EBNyOEFm0dGcVtws+BhX77FL59pttTjIJxIphzI8yVJEpvrKLi8M9B45hzt0rGwf
         BkSUqdZ1lJcbfpAnX9nKjCRowBjIAQTYc4f+V7w7ZmY+19KX9pM7SHqRiW5/z4FU0ciN
         l2Phwr/MgdN1y41kG52dgyJYF8pE8P3a4wU82CmDZvwupbT8dkzOMxAuagFaH1rWyA8r
         nBP1cxbw79DyGuSMTUdkJPb1OeZaVD7aX5hwxveecGTD4QzLDNTTMsy/jpMuth3rxQkS
         D0JA==
X-Gm-Message-State: AOJu0YyqJ65FJxazFyeqQBv0q2t+yc+rOcO1pIn1ZBuLuqvKlHyEfAIR
	/koU/7H5j+WgLb6MEE1ChVtn85jBQDZpzUq9hdBVbA==
X-Google-Smtp-Source: AGHT+IGijv2oaXJrsz4eOoB3TmX4ovkG0ibEUz+P5TLts7xACNH5qB3XKWndGchQRopwNv8LdczoZIB5sx6elgIxlsM=
X-Received: by 2002:a17:902:fc44:b0:1d0:220b:f254 with SMTP id
 me4-20020a170902fc4400b001d0220bf254mr21736plb.14.1701260506633; Wed, 29 Nov
 2023 04:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d9483d060901f460@google.com> <0000000000006547d3060b498385@google.com>
In-Reply-To: <0000000000006547d3060b498385@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 29 Nov 2023 13:21:35 +0100
Message-ID: <CANp29Y4NLk4jd8zhN-VjXWtrDSWbS=Y-ADGxrmboKU+KH2hMPw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
To: syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 1:17=E2=80=AFPM syzbot
<syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Oct 24 09:42:21 2023 +0000
>
>     perf/core: Fix potential NULL deref
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17172162e8=
0000
> start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D429fa76d04cf3=
93c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D756fe9affda890e=
892ae
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12db572b680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10839a1b68000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: perf/core: Fix potential NULL deref

#syz fix: perf/core: Fix potential NULL deref

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
