Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C5241F4
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNetY+09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B6C433C8;
	Wed,  6 Dec 2023 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701870841;
	bh=iOiOJkTHnXU+Cx/umDTZmLjx0e963P9Lpk2W/B0Z0h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNetY+09l8T5OlZOcmBgb0T3ptNyxuuAU5+V+o4vPKuL3Ec0VU71f0CGagHKZHQEi
	 M6bVHDTxWRhoL/jwEvg6lB/47df/cnlWSy6UIVC5KhwGB45Dz9h9AniC45p1aWFYx2
	 wybGsenQoJUvSkBUuHTJ4IZi+RnH2AX5vRqh8o/6g171zdhkecjcZI5KXk7p3wPOkE
	 Ypzn8h0Z3eyv4fkbqSCUf1NpRnL4g+t+KCUKrzcEIXUGO107WFsbGG73VX362Rn2F2
	 1i+MbgMqhlbFedpuyRLAFktaLlKRUc6V0H+f2mn2BXWLpffn1uSen03ScOjk4joZbR
	 uhZ9Gz6XvYr6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 42842403EF; Wed,  6 Dec 2023 10:53:58 -0300 (-03)
Date: Wed, 6 Dec 2023 10:53:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 15/50] perf maps: Add maps__for_each_map to call a
 function on each entry
Message-ID: <ZXB89kzXZC7snUmA@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-16-irogers@google.com>
 <CAM9d7cgC1TXRF8d0VGt-qE4eKACTHA+JLNt95GLRSSWkZMwA2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgC1TXRF8d0VGt-qE4eKACTHA+JLNt95GLRSSWkZMwA2g@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 03:46:08PM -0800, Namhyung Kim escreveu:
> On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Most current uses of maps don't take the rwsem introducing a risk that
> > the maps will change during iteration. Introduce maps__for_each_map
> > that iterates the entries under the read lock of the rwsem. This
> > replaces the maps__for_each_entry macro that is moved into
> > maps.c. maps__for_each_entry_safe will be replaced in a later change.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> At first, I wanted to have each conversion in a separate commit.
> But it's all mechanical changes so probably ok to go together.

> Acked-by: Namhyung Kim <namhyung@kernel.org>

I think we should do it in separate commits, Ian, can you please
consider doing that, please?

I'm pushing what I have to tmp.perf-tools-next now.

- Arnaldo
