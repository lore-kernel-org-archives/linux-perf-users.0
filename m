Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05171B291
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0IMv16W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8973C433C8;
	Fri, 10 Nov 2023 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699627610;
	bh=ADJXJUQ+yQCokhxG3Gpz902vfTvDUZW88gRg9FvUxeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0IMv16WHOf9OHJnWKO+KxsHFlUmJj2cGyUmKPf0XCoXfrBwnDkIJ4l3UwdkLuij6
	 Txyc1CeqIGDKWNgIH2xuW5SQ8VtLcs0izPCcEmi4VHJ/or4w9Hjod/jJMxhkpg520r
	 TTdEZIO1jLupxlG0c3qnwHgTJs8oMacLr3mQySvN+L5Cm+QbHVYMVDhj084EDaQJcu
	 GJBgCCyTDrWw85OJ7QSKfPLBGYbRydNizM/QKZH1P4hQCAp1/vouDq6KLd9FE4moNG
	 kYgZ4QKtywyrOLasZnlW5QzjkY0kBI0WbsMy/cnXZhoGmtAT1JPD/f2w09kaRTo3bi
	 vH1JKPnEPaqgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8594C40094; Fri, 10 Nov 2023 11:46:46 -0300 (-03)
Date: Fri, 10 Nov 2023 11:46:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nikita Shubin <n.shubin@yadro.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] perf vendor events riscv: add StarFive Dubhe-80 JSON
 file
Message-ID: <ZU5CVv0U+Q4BmHeX@kernel.org>
References: <20231103082441.1389842-1-jisheng.teoh@starfivetech.com>
 <CAP-5=fW4T_j02RLghg=_OB1TkRWFuHKOR59xFyEsdEH5gGnUPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW4T_j02RLghg=_OB1TkRWFuHKOR59xFyEsdEH5gGnUPA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 03, 2023 at 08:45:33AM -0700, Ian Rogers escreveu:
> On Fri, Nov 3, 2023 at 1:27 AM Ji Sheng Teoh <jisheng.teoh@starfivetech.com> wrote:

> > StarFive's Dubhe-80 supports raw event id 0x00 - 0x22.
> > The raw events are enabled through PMU node of DT binding.
> > Besides raw event, add standard RISC-V firmware events to
> > support monitoring of firmware event.

> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
