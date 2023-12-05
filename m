Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE760B81
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrclWcSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F9C433C8;
	Tue,  5 Dec 2023 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791796;
	bh=rxx7r4kYMIc5POiSPA+UFcBMnkPATUU27TPKjCSbTug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrclWcSvdEp8X5JfZi9UsGROvTw1ITfTjKbxGAFZN6AWew4mS9aqtLuSwk5OnGQmo
	 HgNKBOeVjU+sSusuEmXpVu+aIGDM1EnHrrGR6ZrGAYQxhx07/7f6qgLu1/E7FmrMby
	 LrxF0Pxb3luwfKw7ik9R5Yi6zkSZH1hXkDTmHBql5O8mMlHv9rbeTRV6EIpDbaVCAW
	 artsmSS1QY6oLZNih6izkTTqOymOv3v/cxCPEtqsG1cOA34CFIvV/Oj7tpSs+OWDOm
	 CnVjAJHKi5aybKcR69es27jKbRIZivWHBAaebs6U9wSmK5VXdcXtxVvlgiPbEkm/ds
	 fgMKVN8t5cHWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8F63240094; Tue,  5 Dec 2023 12:56:34 -0300 (-03)
Date: Tue, 5 Dec 2023 12:56:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chengen Du <chengen.du@canonical.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Parse NOTE segments until the build id is
 found
Message-ID: <ZW9IMo44Q+jM4W7Q@kernel.org>
References: <20231130135723.17562-1-chengen.du@canonical.com>
 <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 30, 2023 at 10:23:31AM -0800, Ian Rogers escreveu:
> On Thu, Nov 30, 2023 at 5:57 AM Chengen Du <chengen.du@canonical.com> wrote:
> >
> > In the ELF file, multiple NOTE segments may exist.
> > To locate the build id, the process shall persist
> > in parsing NOTE segments until the build id is found.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

