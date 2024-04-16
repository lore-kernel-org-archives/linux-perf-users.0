Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C59130A64
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282386; cv=none; b=K8smB1AmS2DKveOsSVg19NNPHINOIyPWp1Lsb+UvN+xNSYo0Hl83yscsgMIzQHP7DdUrro1M7E2/bcKoOfWx62DaiK1A0/EdU8YbFWSFcahpArIb5RnOfUBrIyT07aZOsADfoKk3ErwOC5ZLW5GWHHoGwnMG0iBFDRfyC9fnRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282386; c=relaxed/simple;
	bh=AhdtaZWqIeA8iS+tyS5Hw968uwsIh4kZ+QDKXpq7TTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFTKq+cp/3ehciKdyhc3cHH+GM8pC1xY3NCb0AeULg4V+xSuXpuiXwh4FO0VLJ541QSChlquY+a/n6vGYAljpR2alfiyY0zFkp3J2LeG31vBuFigqalIq/kDw++lTunNygCI3k8QQ/7oXPDpsz3+oA+9bS999Md/ZrTRXUDC81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Bfpgj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Bfpgj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F15C113CE;
	Tue, 16 Apr 2024 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282385;
	bh=AhdtaZWqIeA8iS+tyS5Hw968uwsIh4kZ+QDKXpq7TTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3Bfpgj4jtP5em+Es5xQCmWkYv0IAVJ0P7Se4m94hbICpoNwhc/nD1P26lpuATTWR
	 MsQy9foxwjwlKyellvN70HRA5qzsA+bYkeGLC2+MO09gvb2kpfb/FqrdkGikz7ck4J
	 fNCPubV60cqeH1XU+nucxbJWJFcmcyB0pq/yy77v1guueFEpLy0w8Jtymetluj+TJE
	 srUY6cv2PAAfl8ooQd1IasnZCkTekpU0IMvFK9IbUTcS7LCb0A3ISi1CWYKAvX0zkm
	 27Bu5HELTrn0IpOJjVGM5wAvYbe1amM+aiDj/r/6EwCRWAzUCup2KjHEiOsO5aYJQa
	 ifADGXgHOPS7w==
Date: Tue, 16 Apr 2024 12:46:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dima Kogan <dima@secretsauce.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] Better error messages for 'perf probe --add'
Message-ID: <Zh6dT13FfgdHuMql@x1>
References: <20240416045533.162692-1-dima@secretsauce.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416045533.162692-1-dima@secretsauce.net>

On Mon, Apr 15, 2024 at 09:55:09PM -0700, Dima Kogan wrote:
> Hi.
> 
> I tried to add some userspace probes to some C++ code, and got this:
> 
>   $ sudo perf probe -x tst --add _ZN.....
>   Error: Failed to add events.

Both patches look great, Masami, can I have your Acked-by?

If you find other cases where the error messages can be improved, feel
free to send us, please CC Masami, as I'm doing now.

Thanks!

- Rrnaldo
 
> Note the completely non-useful error message. The issue is that the C++ symbol
> mangling can create very loooong symbol names, causing perf to try to use very
> long probe names by default, causing this problem. It took a little while to
> figure this out, and a better error message would have helped, hence these
> patches.
> 
> To reproduce, here's a tst.cc:
> 
>   #include <stdio.h>
> 
>   namespace n1111111111111111111111111111111111111111111111111111111111111111 {
>       namespace n2222222222222222222222222222222222222222222222222222222222222222 {
> 
>           void f(void)
>           {
>               printf("f()\n");
>           }
>       }
>   }
> 
>   int main(void)
>   {
>       n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
>       n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
>       return 0;
>   }
> 
> I then
> 
>   g++ -g -o tst tst.cc
> 
> and
> 
>   sudo perf probe -x ~/tmp/tst --add _ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv
> 
> After the patch a better error message results, and the workaround is clear:
> 
>   sudo perf probe -x ~/tmp/tst --add probe=_ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv
> 
> Dima Kogan (2):
>   perf probe-event: un-hardcoded sizeof(buf)
>   perf probe-event: better error message for a too-long probe name
> 
>  tools/perf/util/probe-event.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.42.0
> 
