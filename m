Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E832EAFA;
	Thu,  3 Apr 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704339; cv=none; b=uKm5scunfzGPPR08YLrTKSDqTGk+ezcDWbDYSDD5Tu5fVaSeI13gtXh9Kx6yW+M9R4ed3J9UvdVh+WL/9EO061PWBwIca9u6NWasOZ36XY//Z0FFUZh9/cE3VDZRJjVutaCg2n12YV/nBtf0DBb3FQz1fR3G8JJ1XOa5AYlIOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704339; c=relaxed/simple;
	bh=M5N00HnKLSUan93thRh5WJ9MmhDcbNpowslPluoagg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swLuPAXmGi4XDJiCj+Zcp1kmzDL+JuaJ2W1gZF/y+8g0TByh4CPkLNdlUTBdu/Y+f7aAv1gtuSoQeE83hTQ7yTdLKHbeRepKO4dth8kO7A9/klEM0FgEySiU7lraptpiiC/blC/TErmwh+WxX5dtsK4dgOAlEaSpIK/G+FIQeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbNrx3dx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbNrx3dx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff64550991so1001471a91.0;
        Thu, 03 Apr 2025 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704337; x=1744309137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oivgM/oU05SavlSk6ZyQtfDyxaVZ5/OSN3+HJvK9guw=;
        b=lbNrx3dxWJG1mEfoIMxNDHN8vzQuHlxX625NPhDwW/QHsKJy3qiEYxXkTnud040q/b
         uE8R+8GMcd3krMv0hSmgbQ6Asi3a18I5C/wMuU4Hyz3bQvjSVHSOQpnYn2ADXMk61Kev
         syeWQXyH6RXFEUn/XxTP9cf12gxHqM7nSCFJen2/Bzn7LOya1zhPUHgTE1T9zGE+iYtz
         L0GJ0gwWGebTd6n26iaMVoSgxFPmB+K9wxhkK/1KXmR0aMd/WP/D8zO+Y5n4gKWI95ax
         kuyY3DQvkx50LTSCKN1F0jyya4/l3R4R8+KiJfMsAe5teAJLZ6wwif+D9mpf8OqPIbkp
         3hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704337; x=1744309137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oivgM/oU05SavlSk6ZyQtfDyxaVZ5/OSN3+HJvK9guw=;
        b=cq+gs/JmolN2tB+5Q2d+WlS4hZyFZPlGIsl6QrcPYXlDnhtR8uDJHq/O6+qXwmiSQf
         l2S/+Nf68cA9tEGcfhilofekaQi/hUlXbtErrwQu68WQoYvlJWovDLL3aetDKYg17PJx
         dg2MtBlj1eWCdAUbCWdizciTDhcE2txlB0YEQijdD3USR9l9G3/NzQmndNNRICJLDvN6
         emPTWYnQYue3O4NhcbxEo4SMb3lkL3t5il+3xvX0n+d214fcsVHozweFD48NjVV6aWrY
         EKDaS/GgIN6KFsQk85LaSnTSWVmshryPGTey4T7xS/B+pENsf/8hAEEBOI1zhcs3MR/v
         x5jg==
X-Forwarded-Encrypted: i=1; AJvYcCX65lpgMe08LNgINrYy7puIq4f87+UWxevJYrohfAJ0MZNQRk22iLTqxfBnCYAFDp56fS1HIQEXAyDYAqk=@vger.kernel.org, AJvYcCXpr/88v4bYkIpoQQYtNCiVtslvK3+t0UlwTMfDBkOLLCKUqmHVzipvZr1vKEj3m8J6KKTWQ1HVtMFo4yA/xUVlTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvtSEeltfvBQSRWMaQqr6wBpFRdsUD5ACpVU7D1wTIo2TQ1UH
	zIVKToIMLcF2NHqj9ASmRHGj+7nbcOwLYeC3FIgAv5S7awB1CrDm
X-Gm-Gg: ASbGncufRMjJnhz+sQ2FkD8yYLuooJIb0Ne/t1O8OjTIE/IMJl4Wpz61ZeiIdXcz3B4
	8O8ogSV13RqXIfOP27hJ0Kx+qKOboC3SIFVRs+1LeHKd2Wlx+g3aDVYI9pbw0K0xl79phoizE1x
	nyA4bSBeNSQy2tDJ6V+7xIGCNevKjdvUQ0NLuLIyOv9MBwL4Xu+t8ZY5e0ad9qUZs2UBph54weS
	+1+2m+AjAylCwsgJ5Q7xKZJ2V8dABlF63nIBPBjzWhOyXooVScuCOMDSU6SmruJvmIkSHu0JUxH
	DmEb+sYSv2UqgZdPBdAlWPk7lmZ1UhSbV+SgSkRzGJpj
X-Google-Smtp-Source: AGHT+IFuaMbU+XKrkn5Ng28elo7CBSiie4K0f2h0FqN4hLafmF2c3xz6u0jjXgUkA6eub5kjms80YA==
X-Received: by 2002:a17:90a:c890:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-306a48a9cc1mr937759a91.18.1743704337319;
        Thu, 03 Apr 2025 11:18:57 -0700 (PDT)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5a823sm2023497a91.34.2025.04.03.11.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:18:56 -0700 (PDT)
Date: Thu, 3 Apr 2025 14:18:54 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 02/48] tools headers: Silence -Wshorten-64-to-32
 warnings
Message-ID: <Z-7RDmHVWqJWS1aV@thinkpad>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-3-irogers@google.com>
 <Z-6WY4a6RV1bEbNU@thinkpad>
 <Z-6aoJ3ohVHPsF0A@thinkpad>
 <CAP-5=fU6E1_8Vzki1dVyb8hDEYOXaSNSrJJkR6AOU8xqvknT8w@mail.gmail.com>
 <Z-6n-3ObiNNLQzFw@thinkpad>
 <CAP-5=fUg_QmWBRUM4tc7zF-rCP9D5+=AqP_FPPYiFEybhcvbhA@mail.gmail.com>
 <CAP-5=fUkoiZXL3J7A_pjP07fY+vv3Gs0BHXMXxpo1NOngXKtrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUkoiZXL3J7A_pjP07fY+vv3Gs0BHXMXxpo1NOngXKtrA@mail.gmail.com>

On Thu, Apr 03, 2025 at 11:12:30AM -0700, Ian Rogers wrote:
> On Thu, Apr 3, 2025 at 8:45 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Apr 3, 2025 at 8:23 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > On Thu, Apr 03, 2025 at 07:52:45AM -0700, Ian Rogers wrote:
> > > > On Thu, Apr 3, 2025 at 7:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Apr 03, 2025 at 10:08:39AM -0400, Yury Norov wrote:
> > > > > > On Tue, Apr 01, 2025 at 11:23:00AM -0700, Ian Rogers wrote:
> > > > > > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > > > > > inadvertent truncation. In some instances this truncation can lead to
> > > > > > > changing the sign of a result, for example, truncation to return an
> > > > > > > int to fit a sort routine. Silence the warning by making the implicit
> > > > > > > truncation explicit.
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > I'm the first person in the To list, but only a couple patches in the
> > > > > series are related to my area. If you want to move it with me, can you
> > > > > send bitmaps, bitfields etc. separately?
> > > >
> > > > Hi Yury,
> > > >
> > > > If you think it is worthwhile. I did the series to see how prevalent a
> > > > bug was in perf's code - inspired by Leo Yan fixing an instance of it.
> > > > I would prefer not to be on the hook for all the kernel warnings :-)
> > > > Perhaps casts to avoid changing bitmap_weight's type. Unfortunately to
> > > > get to where the perf issues were I needed to clean up header files.
> > > > In the bitmap cases the change is just to make implicit casts explicit
> > > > and I don't know how much value you see in that.
> > >
> > > Your changes  are technically correct (except for non-synced kernel and
> > > tools), make the code cleaner, at least to me, and address pretty valid
> > > compiler's concerns. To me, it's worth to apply.
> >
> > Ok cool. I'll make a separate patch series for them. Sorry for giving
> > you such a long patch series with limited signal to noise.
> 
> Posted here:
> https://lore.kernel.org/lkml/20250403165702.396388-1-irogers@google.com/

Yep, I see. Let's wait for a while for any feedback? If all OK, I'll
move it with my branch.
