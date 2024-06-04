Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2214B944;
	Tue,  4 Jun 2024 20:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531487; cv=none; b=FVUvWx17CC5QWdkSBXSldzrqtcOvmb7XvGT1Nriy79KgxMTNUSW843niCZN/gxiRohadks+bw7lWPfyNzq+akmjageaNYgWUJnSxIixqnh59ybUlSzhgpNloR8zk2kJ/QHhgffXOFmMzdff3UuJB/ZoNLp0dEtdlyjLWNRdTbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531487; c=relaxed/simple;
	bh=crPZrtyJUF6P/W6RzF/ufM7lrORJ7ls8iYHOv3tq59s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VACEfYuCKE+3DcyuL6TZBjUH8qFncxUdcCT9ZXZCM09Hg3u7TO0bgGoK823UlGUJJqmdFlU2hghfdFshAqC+C70j4IsYVqTnMhkrWHXkOkeemERT2e0fnxyd+rAPDAd2mjX6wUAJyqUeYY64sXOmGIPZMeki1+RK5vgOyNWLFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=OL8r2c7Y; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="OL8r2c7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:organization:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1717531483; x=1718395484;
 bh=a9YiPhVAz+SdwA7sloQTRYU93tiNcH1GTW86+3eyaIg=; b=OL8r2c7YvACG
 3patbr3+MXkeBohJ4F29AhzDHcY21fSmQKUxsw5wjn6QpX6d7G9erdryvCKeh6qN
 RYkrYZvMdIUCFTYx6QZ2EFln2PCD/R+M1KnvlYCord2DlvmzyErF/qnkvMDmPaYw
 AuTCzeYNXnDFszITdJqSaJWMRl9O8E4=
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Date: Tue, 04 Jun 2024 22:04:42 +0200
Message-ID: <7152491.mzf3CD02m1@milian-workstation>
Organization: KDAB
In-Reply-To: <Zl8g1LxRCYgTSxhy@x1>
References: <23879991.0LEYPuXRzz@milian-workstation> <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Dienstag, 4. Juni 2024 16:12:36 MESZ Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 04, 2024 at 10:50:00AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 01:44:18PM +0200, Milian Wolff wrote:
> > > the following command crashes perf for me, is this still an issue
> > > upstream and should I report it to arch for backporting? I cannot build
> > > the official perf/ core branch, so I am afraid I cannot test it myself
> > > there:
> > > 
> > > ```
> > > sudo /usr/bin/perf record -z --call-graph dwarf -e cycles -e
> > > raw_syscalls:sys_enter ls
> > > ...
> > > [ perf record: Woken up 3 times to write data ]
> > > malloc(): invalid next size (unsorted)
> > > Aborted
> > > ```
> > > Backtrace with GDB + debuginfod:
> > > ```
> > > malloc(): invalid next size (unsorted)
> > 
> > I reproduced this all the way back to 6.8, trying to bisect now, thanks
> > for the report,
> 
> Can you please try with the attached and perhaps provide your Tested-by?

Works a charm, thanks

Tested-by: Milian Wolff <milian.wolff@kdab.com>

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

