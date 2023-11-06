Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89113B677;
	Mon,  6 Nov 2023 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/5n1Tpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E7BC433C7;
	Mon,  6 Nov 2023 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699306527;
	bh=Zw3vYH8zoR3MlXxt86euMwdRDqQReCKtsJxBaa8jPdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/5n1TpkXFwoRTwjyDMA4LlTK6sN//jPm0Hr/O+sxbOoggda37Bs1iSWmZplXqLka
	 ZPF1ymRDACy53RH3KPUlJxNq5Oo6UomU3syNYOOiW9aAGd9vNi+d1yy8RitiYLgP1G
	 UxNLfxzy5045XFYBNXiICEpj/nbzBrMt+gCn8nOvujfIoj0w8a65atwk4n1fG7i9Q8
	 biwoBjqlK9rcXwTwyIRY1WhNtDKg4nmwotaftM6Ty3NcJrQ9QlqgXfX5LKkSsJQG/C
	 iuqk/9GB/9iqQ7hHt0xDZZq55Wo+jtwKxq+/1SO+fGDJ0yzfcTrIaZITTkOIoWns8n
	 uaquuFjvtuqeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2304C4035D; Mon,  6 Nov 2023 18:35:25 -0300 (-03)
Date: Mon, 6 Nov 2023 18:35:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>, colin.i.king@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] perf: fix spelling mistake "parametrized" ->
 "parameterized"
Message-ID: <ZUlcHUW3shZxtthz@kernel.org>
References: <20231003074911.220216-1-colin.i.king@gmail.com>
 <CAP-5=fXO6+Cgvo4BmC9fgL70FY+ciPjRVR5qghxYBR3VSB7WNQ@mail.gmail.com>
 <6929FC3F-06F4-45D1-96D4-0ABF86EA8698@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6929FC3F-06F4-45D1-96D4-0ABF86EA8698@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 04, 2023 at 01:43:28PM +0530, Athira Rajeev escreveu:
> > On 04-Oct-2023, at 6:37 AM, Ian Rogers <irogers@google.com> wrote:
> > On Tue, Oct 3, 2023 at 12:49 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >> There are spelling mistakes in comments and a pr_debug message. Fix them.
> >> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > + Athira Rajeev
> > Reviewed-by: Ian Rogers <irogers@google.com>
 
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>


Thanks, applied.

- Arnaldo
