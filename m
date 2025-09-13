Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949A2F066B
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Sep 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757775064; cv=none; b=uElDckpNi/twWDcDT/elgMBmz9V9k4oRk+q3spwvk6BJCT8DkNWa0KedxoyI7W0oflSmbjN6eddbCxzeSyhVFS3Oys7bsZd2WgVYm1/hQRSKskmJgpDZOyz+upH6IP+YHsmwPr1O/fTDSPTrbCTzUsToXUoJaFQSX5hwMB5yoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757775064; c=relaxed/simple;
	bh=s7XrcQ3h4gUphghTnXP7a28K9Tu5GkC8BVDFlJQWcAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlv/UdtGWQA41ppmlBKiFy3zR866KA6dYNiDm18jBT08OmDo7mkts8NC+qoWA2b+SSl5ZC0PQPwunxcGWoM+z3TAH7ish9GWKX6WxfNz/HR/KW8SAYfGsCp8B6zfMMgs+FA60yKe5nckIJs3iO0hnt3NNsslCFur7MeyKpKsi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEAF1GqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEAF1GqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D0FC4CEEB;
	Sat, 13 Sep 2025 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757775063;
	bh=s7XrcQ3h4gUphghTnXP7a28K9Tu5GkC8BVDFlJQWcAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEAF1GqV0zm4yBlwzyyUKgP8nFguUA+3IU+K/Ek0vW4QqchI3zSkuLIXIn3M8xLkb
	 MhzfJu9VrxhLuolXM0JSaAG9TfT36BMUzo+xx2054049qtHFmFmdfSuoqJ5nGdPg/e
	 b00W5kAru2C06mECxK6mQ2k9Ig/FhZUCRLXyyhJbFEGJgu5vw4zZR2FX7A9wRF4kj3
	 svR9da7w896UrU3HJ8HAYX8WVBFXTt8qPEVlyJoP/UcGqJmnyQViKhG9amwNzbLjhS
	 4mAlN4I2Y4HriaWutVEc7zYoHTXzU1HtU9XNSfmRHcfRse7hiBYR+vm3aHtUif5T+Q
	 bYEazXvcIZj7A==
Date: Sat, 13 Sep 2025 11:51:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, hbathini@linux.vnet.ibm.com,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Tejas Manhas <tejas05@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
Message-ID: <aMWE1A-ruPozj9f-@x1>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
 <aJ5FvBa4LPhMO0u-@google.com>
 <4772D6D1-D61B-4269-B20F-17A387CAAAD9@linux.ibm.com>
 <D3D67CAC-C609-4C25-99E3-4E130E2C9AFE@linux.ibm.com>
 <CAP-5=fXMKoF1z4TPDJhBFqz8gRdXcrCBTJdBvRLhY9rzrCFxfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXMKoF1z4TPDJhBFqz8gRdXcrCBTJdBvRLhY9rzrCFxfQ@mail.gmail.com>

On Wed, Sep 10, 2025 at 10:46:04AM -0700, Ian Rogers wrote:
> On Tue, Sep 9, 2025 at 10:56 PM Athira Rajeev <atrajeev@linux.ibm.com> wrote:
> > > On 20 Aug 2025, at 10:50 PM, Athira Rajeev <atrajeev@linux.ibm.com> wrote:
> > >> On 15 Aug 2025, at 1:53 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > >>
> > >> Hello,
> > >>
> > >> On Thu, Aug 14, 2025 at 05:19:08PM +0530, Athira Rajeev wrote:
> > >>> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
> > >>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > >>
> > >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >>
> > Hi,
> >
> > Can we please pull this patch in if this looks good ?
> 
> Tested-by: Ian Rogers <irogers@google.com>
> 

Thanks, applied to perf-tools-next,

- Arnaldo
