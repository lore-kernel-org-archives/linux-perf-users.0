Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BC433D0;
	Tue,  6 Aug 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963902; cv=none; b=BWS5/ZSl+kNPAs36SdpS7o62Jn/GI0k2T75dPOl+tpIRXDSv3WqbLBkWjwOSZKTpAIQ5sq64BUrPOxr4vfx31yqvzuI5BPZW0QGk7WJZgJ4wdXjhFpwC3IU+F5hfXLw16PXbCd/h2smz7+kZmSyiqeAlSdIYVVTxZTVlCfO+0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963902; c=relaxed/simple;
	bh=J89hljmcuXHDqlr6QTmQWGz1fYUSlBmB823jfyPm0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMvnXAL2Hmb3+ShZS/XBCvK2AUFPwB0sTdTld2RHzoucGrnf4DfxksAev9rfubCoS4RmzQ+2Dy9HNubG3Y2+wQnvqXJCbk4wPBDQ6ouhP9M6XPEIcTc2JkowpddbICeiQWX6Zh+Wagf6lt30JvdGzniOfaYaxmp/n1In3n2fV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciRFEKNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciRFEKNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7285CC4AF0C;
	Tue,  6 Aug 2024 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963902;
	bh=J89hljmcuXHDqlr6QTmQWGz1fYUSlBmB823jfyPm0RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciRFEKNnEB8G5GUHNKoJYeSGPaKcRyHKOW3nFgp7mdUV6WPk3M/ghy8UeaG8QyVlf
	 jgaIP2g9IDNnBuCWswHyZGp6bc7blRpoDS70Kgif/eNGBqGfNz9xtwm6qT7f6RBk0R
	 Pcj3v9B+9BAoI2yF8k+1WbsVVanH4RNzIzMdNxIMiXi7ezN4b5CQSlCphz+oKzew39
	 aXCuG9wryXyfjhvX2062B7xpXTYwKhAc7T/oQb4+6iOKT268JDyi3pM5vkzT+B++cQ
	 PefPwLKN7EJqWnxNxt5PveUNpFFoZPmbY/Su4gz8hvYs+JW4jpLSeP+y5/PvIr7/u6
	 svQxKvuIhAw9A==
Date: Tue, 6 Aug 2024 14:04:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eric Lin <eric.lin@sifive.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Atish Patra <atishp@rivosinc.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware
 event
Message-ID: <ZrJXunNsGiZVVtpE@x1>
References: <20240805194424.597244-1-irogers@google.com>
 <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
 <ZrInOywRKzRmjtKF@x1>
 <ZrIqR07cYJnhcTq8@x1>
 <CAPqJEFoFfCG0_fqkVqakUK7CWs_8WREpmAd+f3H26UasGRPz2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPqJEFoFfCG0_fqkVqakUK7CWs_8WREpmAd+f3H26UasGRPz2Q@mail.gmail.com>

On Tue, Aug 06, 2024 at 11:50:01PM +0800, Eric Lin wrote:
> On Tue, Aug 6, 2024 at 9:51 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > On Tue, Aug 06, 2024 at 10:38:07AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> > > > On Mon, Aug 5, 2024 at 8:54 PM Eric Lin <eric.lin@sifive.com> wrote:

> > > > > I've sent a patch to fix it and the patch already merged. Thanks.

> > Also, already merged where? Upstream? In the riscv kernel tree? where?

> The patch already merged to Linux upstream:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63ba5b0fb4f54db256ec43b3062b2606b383055d

Ok, I'm resolving this with removing Ian's patch and doing a merge with
upstream to pick this patch and keep perf-tools-next building.

- Arnaldo
