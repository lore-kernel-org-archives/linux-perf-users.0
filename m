Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552513FD92
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531107; cv=none; b=nbEkxf9RG2AUyJyjpSQdTN+h57zGYho2aIXYa8jy8LNkwiT5BZYtSiGXx3z7dvzLMDwxwu5rcoWz6mChOp41rHDZvkH0A42e1DskP5p9jWIIS9fjx7zGfHkHTHvHHiELRGYT3yTMyMbUuCNIjCwkbh5+Zr5Gq4rFM+dQfFMdnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531107; c=relaxed/simple;
	bh=izz/e1HtS4XBiKb/LQBzieVLigBslpw/UhTUE5p93Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1H+lh850IftGW91q2aiMw2FQW1EIHXd+Jw7c/HnT9jBS3RiCLZf6q8VpJDA2JnoqWZaRmEZEpSm6Sc1gyxijKp8GMkC+/BqyW4QyyTr5ffO7ocDecTEXlIY85VTgTMWperMwh/VrwYwTPipN6H2eXePohchCYwsw1HHBvJFOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=rlt3bfey; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="rlt3bfey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:organization:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1717531101; x=1718395102;
 bh=DwaB6P8mAb6qzlSstFdg1iOoaMbkYDPt/LLRH+5ikdM=; b=rlt3bfeyuBgu
 nqEbQ7FOjRF8kXGTigKOjrycFMrH/Yj1sK2/j7x+kFYi/xSX86Nf4wUm39BREMlS
 tjGBuyAQmZgSAJM4abu0SfduSs1FdhUQSXZfsgobgDCXKhk8v8Rv805nagTGSLlH
 bK+DR0l0l0uRWBKw4NU2j4+IQ5vbcZk=
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: perf FTBFS due to -Werror with gcc 14.1.1
Date: Tue, 04 Jun 2024 21:58:20 +0200
Message-ID: <4396113.DFci0H2nWq@milian-workstation>
Organization: KDAB
In-Reply-To: <Zl8akMdx92DdF7C_@x1>
References: <11178410.LHx4AX4RY1@milian-workstation> <Zl8akMdx92DdF7C_@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Dienstag, 4. Juni 2024 15:45:52 MESZ Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 04, 2024 at 01:40:19PM +0200, Milian Wolff wrote:
> > Hey all,
> > 
> > I cannot build the acme perf/core branch on Arch anymore with gcc 14.1.1
> > and
> perf/core isn't being updated for quite a while, we nowadays update just
> the perf-tools (current merge window) and perf-tools-next (next merge
> window/devel).
> 
> Also I still keep my tree uptodate when I'm updating those branches, but
> nowadays the trees/branches to be used are:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
> perf-tools
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> perf-tools-next
> 
> As Namhyung Kim is a perf tools co-maintainer and keeps one of these
> trees+branch while I keep the other.
> 
> Right now I'm taking care of perf-tools while Namhyung is managing
> perf-tools.next.

Ah indeed that's it, thank you!

Which one of the two would you recommend for interested parties that want to 
keep track of perf tools development, i.e. what was perf/core?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

