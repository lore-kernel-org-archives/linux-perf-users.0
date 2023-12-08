Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8F137;
	Fri,  8 Dec 2023 15:33:39 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28694702c18so2622843a91.3;
        Fri, 08 Dec 2023 15:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078418; x=1702683218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEXP4rqwUrtF27vNtvXQpGVAmBWWtDoL7HKm4QVLjsU=;
        b=KgLCyzCDV0gLuN4SFy+phz5Qd5Z/O2eOPlereqq/t8BfYJJoQGUJqsUI4knHE5Ij/R
         sFQsy60gijQJUyuyvxm9xIJ+dGKZylCQmBfNlKDNn1jiTgfRgyOgHp3V3IFTnHCXQjQw
         9YtO6F+fc9mRi3w0MRzXdM/+1xOB7EhI6sF3SkLoc7qC3ct5W32jPc0tiPR/veDXIjEc
         A6O9N9lUN2chMAaCZG5uuIalSQzZGZwCttLXDBQd7vo9wV51GzrdgA7vuybJ5USDSN5s
         bbLrF09KOMWs1MT4IdOI9lof9N/Pp6kdwuBjM5gChftIBPYamxB/c9/lZR0ixOjpxt1v
         1tBg==
X-Gm-Message-State: AOJu0YwAeOJv4zH+bCDH90oGkj8w9Y0r0x96JO/9CFQUH3VX3PJjHzOX
	Sxugeeu9dJPiJrCu8iYRJMHmq7XkBs9az6d9g0I=
X-Google-Smtp-Source: AGHT+IE3J5k86IaDJ1H6zfZyV8Gj1OTLhdT+R9Z9bMT3Y7WROpINtLwegjkBogj7Elu3rWnk3neZp2ooTNhoTm0WFE4=
X-Received: by 2002:a17:90a:e50e:b0:286:ca3e:be8c with SMTP id
 t14-20020a17090ae50e00b00286ca3ebe8cmr815098pjy.90.1702078417649; Fri, 08 Dec
 2023 15:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107083331.901-1-ravi.bangoria@amd.com> <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
 <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com>
In-Reply-To: <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 8 Dec 2023 15:33:26 -0800
Message-ID: <CAM9d7cijrZzp=5m+BcQ77WFOSHT7e5vO-RCUTUp5Pevmz2wbtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: acme@kernel.org, kim.phillips@amd.com, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, changbin.du@huawei.com, yangjihong1@huawei.com, 
	zwisler@chromium.org, wangming01@loongson.cn, chenhuacai@kernel.org, 
	kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandipan.das@amd.com, ananth.narayan@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravi,

On Fri, Nov 10, 2023 at 1:46=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Hi Namhyung,
>
> >> By default, Perf uses precise cycles event when no explicit event is
> >> specified by user. Precise cycles event is forwarded to ibs_op// pmu
> >> on AMD. However, IBS has hw issue on certain Zen2 processors where
> >> it might raise NMI without sample_valid bit set, which causes Unknown
> >> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
> >> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
> >> use non-precise cycles as default event on affected processors.
> >
> > It seems like a kernel issue, do we have a kernel patch not to forward
> > precise cycles or instructions events to IBS on the affected CPUs?
>
> I'm not sure how it's a kernel issue. User can use ibs_op// pmu directly
> and might hit the hw bug.

Sorry for the late reply.  I know it's the user's fault when using ibs_op//
directly but I think the kernel should not forward cycles:pp to IBS.

Thanks,
Namhyung
