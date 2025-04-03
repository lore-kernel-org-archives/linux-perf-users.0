Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B924EF75;
	Thu,  3 Apr 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690405; cv=none; b=tBsbfhZkpQ5YCj2fySMO3rNJwVNqAKFs2ROpaB1V2zvUQpmysDszHx9SABgjFlGYWAxwvJ7iODY9+zbzf+tmcD6qeNtqJ8SPWR9SdGDDAZLlTMHYFs09LlMCV9xBdJ2b6XOk1ayQj6bGQy2QZRpXT+ey4RFfEcqRxXdKPp5EglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690405; c=relaxed/simple;
	bh=udWx3sXynBeCKyH2cn9MPdye1p1GgTvwWlCqpxIZr1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8y6/4YInZdFgSzPx9YCjjsms4S6UMO6XZF1hR4k6NV/aAogM45iEn9eVXmT/vsvd41Kddq05lO6u+mEPvudrpNnbHaVtol7Tu9G+Mn8QTdQnyn3UM3hxG6GmWZ7F7s384/227K8fZv/oQGgnpoHrqSeocLiuBW1uAR1Z6XiJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLWFgbwp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLWFgbwp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so932837a91.1;
        Thu, 03 Apr 2025 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690403; x=1744295203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAqtWD0ADgEG56estGUMwFFZOWZtTFqA2jD3PNCtf2o=;
        b=iLWFgbwpzBc+owroak/XvmCW0A542VFOPvJ6/59jkk4Ii1c3GemJ78msb5Ex8b5SY6
         ENtawRrn3nnrhLpRGDFDZ3PPCfKHl9jrXmvRzLZyncstHhY54R97gSQeGqSTfH0tK73V
         7D1zKYEo/BoF0pyAPxD26Ler3SB1Kf8TDUEw9DQ0qcPINr5Ecryzs9TR8DybnUjTCI0Y
         2jx6BUTthRT62wWKzLPJC8nt8UGvxkJfa7dLKNg9BOoXulAbnV1W//hJCANyyVV/eNDS
         OV66J6qflTMrEgbvWZwea3MXlmFv7YFzgMxxo5oqAYNPrBq03iAQRqVU8D1x/4ZLeNY4
         gjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690403; x=1744295203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAqtWD0ADgEG56estGUMwFFZOWZtTFqA2jD3PNCtf2o=;
        b=D71+BQlxlIBj7wsFYiFq5pJ2Ys8UE7b5rLOQYdvH4F+kfuaBlYo3ATIaMDroFwtPh1
         hKeUcXGY+LKNwUMVJ/lNS48BjrD0AIA0PmRwJL7bef8WY/G+H0C2afCM2rOQxA0KaNct
         0aQ7ebXBZDFyUV5KK6q+9EeBcSLEPxqvIq+jk0WxooawoSBKZnfhJVAQzPEI3yx7oVhk
         0MvJs/JSkmfy0ZM0Kd3u6HrqyJPuDqDjV2FR1kd7oq82bQJhZiuLaWkvE6qTpBYwqy0Z
         4UgCsFCBmz4fKchQuBvUNcroJF913mgDKzC0fM4bfW1e12mxpTpjtt6MDPc3m/XWesfd
         aSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWviRsVAzhakPyElNYL3bnI1cApUdk0Wbu+vkwZYKdblOI9fOJoAYGVOccNGMAHTeIepEErKdm5gNiuaj4=@vger.kernel.org, AJvYcCXLvkVwc46x7OnL7jcls0CPRG9CHEkCNXZ2O7KmeVZcJOjUwXuAx3eTGi4tHKk2ZTNNqoHF51diTbrMqImPVwKSqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KydPx4mv/kWKoRFakVwCGGg5S2gZXk7A731xZ1mr/4vuwlHl
	fuuumluftIe3RTvoyhfUP/p2F9R/NkeAtPAs0Fqt4c828pa/Yhz2
X-Gm-Gg: ASbGncshKNPp/DL2Q+LsQAEt8TjyDXAtBKkObRYKgmdIa1t1hCM+/lo/KBiLESNu2jA
	PcYdhLQghArtmYX/3y3dMcwO44iUURic94ZDuvA+taWurEI7yAzi483j9n3PTWkNDJtKivGGmos
	1SdqcoYFKbYX2WFnlCPoZm2UwwOy43vSf5er18zeMO43WqV94hrSwuTn2web3+j5WnWcfupoPkV
	Ou0EtFm/l3YLuIBfM2yvB1jowgAAfcECzQeTB8pdwa41Lr9ev18TFkHSNea+nWgdZHjmLdE1l+Y
	8b3Woc6ccdVaEERJIcVzId+3x02ofKii1yfWxfS2GyU98Rz5MYsp0Cg=
X-Google-Smtp-Source: AGHT+IFj+34X21Ko9H2G+bwo7MdL+I8gIE9fAmN87oglS5pPqEZNB1wO4Hk8sbSK66cTHRHvmK8RIg==
X-Received: by 2002:a17:90a:d003:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-3056ee4868dmr9516913a91.15.1743690403134;
        Thu, 03 Apr 2025 07:26:43 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305827d70b1sm1548261a91.4.2025.04.03.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:26:42 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:26:40 -0400
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
Message-ID: <Z-6aoJ3ohVHPsF0A@thinkpad>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-3-irogers@google.com>
 <Z-6WY4a6RV1bEbNU@thinkpad>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6WY4a6RV1bEbNU@thinkpad>

On Thu, Apr 03, 2025 at 10:08:39AM -0400, Yury Norov wrote:
> On Tue, Apr 01, 2025 at 11:23:00AM -0700, Ian Rogers wrote:
> > The clang warning -Wshorten-64-to-32 can be useful to catch
> > inadvertent truncation. In some instances this truncation can lead to
> > changing the sign of a result, for example, truncation to return an
> > int to fit a sort routine. Silence the warning by making the implicit
> > truncation explicit.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>

I'm the first person in the To list, but only a couple patches in the
series are related to my area. If you want to move it with me, can you
send bitmaps, bitfields etc. separately?

Thanks,
Yury
