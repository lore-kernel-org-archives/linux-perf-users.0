Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808D381CD
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUvpcyLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F98C433C7;
	Mon, 27 Nov 2023 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701122002;
	bh=HeDiF2jwasV0GP+dtz+9Y1Dd+DYvHNFxhjLYvyamAFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUvpcyLGrzjY+THGjy5pypahwuW47YkS6ybPWEQZEoIlIF1NahoVSiF5udEasg+4x
	 ItrolP9+i5SKZUXjFtqm8o9iXMTM9rpXjqId1ZHu4o5FLXulZebxzb9Ut0/1q+ADP8
	 hoNQPwBqj0qapVVahubDIoXd8zAerxRT7jvKeoOKAsgYD76EAUATrcmKyXZndsxX24
	 eKF/PHLeffa+eM4jKKveodshh3xHGa02xJWcI2bp8hE9r6UBDjzye0iL5c2xvWGOj0
	 z2NOQd+2gkMTgqnrXZTJQKLMhHUgaHoztyOHlfMeA713T/Gkjbg8QM/1pAC8knQO2q
	 WvSPXtuSudmwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3929D40094; Mon, 27 Nov 2023 18:53:19 -0300 (-03)
Date: Mon, 27 Nov 2023 18:53:19 -0300
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
Message-ID: <ZWUPz6ETFEBsrDkZ@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Sun, Nov 05, 2023 at 09:31:47AM -0800, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The rwsem is only after used for writing so switch to a mutex that has
> > better error checking.
> 
> Hmm.. ok.  It doesn't make sense to use rwsem without readers.

Well, the only reader is a findnew method, that will primarily read,
but possibly write if it doesn't find it there, so converting to a
regular mutex seems sensible.

- Arnaldo
 
> > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
> 
> But I'm not sure this is a fix.  Other than that,

Yeah, agreed, will remove the fixes.
 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,

- Arnaldo
