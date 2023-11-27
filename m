Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991883EA73
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuTC72HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392AC433C8;
	Mon, 27 Nov 2023 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701122409;
	bh=FFALWKc/ZBfqGfDdhBIDp6jyuxWJOXHiknj8f6bxGxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuTC72HSX5/ni6VtI6ee1ReyY5DM23etTVmz+W2dS1CZNxpRduOoSrK+NKhE1t792
	 oN+W8RptKeRvwXtbiTZR/253B0TKUwphknKx2yOWKz7gRqJ6sCg0MgfkGnfJYhrFVw
	 cv2AGseVPutOzVdNMRzH+K5rmJ2fLL8LhiVFt2CWRvm4ezgw9dLW7KWDZaZmiqx1WL
	 DPTgywCoQW2OpU83HWGVdP4AWY1nKjDGkUKjCeZPuL7GPW0ZvziMmNN2504RSszbh8
	 OrUdNYc2z/eLFoez7Ct34ShdGO5QpwiAY7nC/imxdxohqFcqLNikeQEYhsH/oTbl+3
	 W8O3HvqFg5Q5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3B4BF40094; Mon, 27 Nov 2023 19:00:06 -0300 (-03)
Date: Mon, 27 Nov 2023 19:00:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 04/53] perf mmap: Lazily initialize zstd streams
Message-ID: <ZWURZvDA2L4Mr3HR@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102175735.2272696-5-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 02, 2023 at 10:56:46AM -0700, Ian Rogers escreveu:
> Zstd streams create dictionaries that can require significant RAM,
> especially when there is one per-CPU. Tools like perf record won't use
> the streams without the -z option, and so the creation of the streams
> is pure overhead. Switch to creating the streams on first use.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

