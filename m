Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6D296BC8
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670981; cv=none; b=G18BiQJMEZ6gS8AYgXq4tzh0xsCDYIF8w/bLFkhCugxTZJK4jkii3JtsIexXIfEWf18OEceLUSzLbdG6kigw3TckcyHA5YG6UWK7NW7Rw8oTjP+wPzMwKVsrXdJQIMLnyR0nocWsf6zxfnhU+S11o6eNi/+KEhnP+reudWJ0WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670981; c=relaxed/simple;
	bh=XJhs8nvdwzfX2HkmstdJj7gCwFVlaG+qYejhLxhCD5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVNj1sIbrndKa7TZlPvF3iNI4C4agZaGAkzxes9SKZNvPw1pPVHWM0m+ndR0OMTT70CJssTNlsOFkV5X1/wQBgSpzuP8MIqxMp/u2IOwGisO7d3gCSHjYgJEvZ+a9dW2bRP5ctxSv9SKthkYtVdri9yF4b/c4hdiNQgfRSwsKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xak+ZKYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xak+ZKYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B151F00A3D;
	Fri, 14 Aug 2026 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670979;
	bh=XJhs8nvdwzfX2HkmstdJj7gCwFVlaG+qYejhLxhCD5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xak+ZKYJ0UIjEGTF94AU873UAhn7iBAm0CvN9J6yDdwCvaMpLoOI+SVu7zDHXwCEo
	 p371uOYOi1BlBuIfEuKCiCs8IpQZANbfI1OBtSipn2HjwkXrlYK6vBUZY1H+PbdI2N
	 P+slzx2TswYh4KRz+BJU0+v763S9KzXcShUD8V8/b+1k7CT7IAXAM5s2a4Z9b1ZpEN
	 4RBNmp4aa72lWVrh9pcxF9DtAeYfs/gdPIozkMzkjtWww1ZeWwmG7jKS3WLvgaQ/Sl
	 SPwRIkP3jhPuk6hfEiC9eq1jmhepjdST9vLuXbbQg6DNWGOPUbUw2WcFhlhCmY0yJ0
	 0iLRqJr/DD0Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf tools top: Add --weight option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813214143.253418-3-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
 <20260813214143.253418-3-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:29:38 +0000
Message-Id: <20260814012938.F3B151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a -W/--weight option to perf top to collect weights too. Useful with
> follow on patches.
>=20
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813214143.2534=
18-1-ak@linux.intel.com?part=3D2

