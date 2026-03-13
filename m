Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AD397E90
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415154; cv=none; b=JfVUflSubG2GnEe+X62SHh+nTSR0+94O+wh+TG31fSqJ75Hik3wvzxu09iiic/6K6BW6slGTJGwG8thbdBuQKKOvJyYj3I41gbEIZZs5MxREgaBaZWFILix7dQ/XiUdhDk3oQdTzp2W+KClsKvf0kkvIERRbdGcA6wamHR3NOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415154; c=relaxed/simple;
	bh=Eh3gjA2sctTF1oNwcOYglGKzXLhEx21cV9/Jjd2sn2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iivm0Z2i8cnFzhDYBW1HK1VGftpSDMfzrRITNVerQtTGmoqeDb87HxL0xIGiY/xGAlma06+xxXagb6BrjIl9GkjQ9S1SScA7ufg19SAR2705FOY5X4Hjj7KAOVwjZiy4kxDvLaiDi7PH0bl5V/bEfbmQo1u7v3jsVI+1WTrvB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEGMi9ls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEGMi9ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE8C19425;
	Fri, 13 Mar 2026 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773415153;
	bh=Eh3gjA2sctTF1oNwcOYglGKzXLhEx21cV9/Jjd2sn2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEGMi9lsYiLQv/vLwjFRgGGjmDMK8E3IXpWOVG+C3Kwze3mTNl8Ic7Bfm04HS0kV5
	 5QR/MXEe+xEhJBSN48ps492Vm0oc0Hw4evEeiAbghN1DhxcGlwg9fgv+6sdGq8kQAC
	 oNNULQhBQbfbTozChqq1UWyhldF3THh1fi4oTEvJvwHCNslaVxK9zAi80HIT6dcbCm
	 ESZIGQNt6IbyhWvemNaToHT5TKjDlVoTDBjojOAQZWzlpPFtz4KAkkPg5gX6nlFPbD
	 Ud6rHBZicYaa0jbkoROvsf8/9XjK+0c/qrke+Icot0/SiNxE30Ig7v5piXVeqRTRuI
	 5eRRvZ98UqcHg==
Date: Fri, 13 Mar 2026 12:19:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Jan Polensky <japo@linux.ibm.com>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abQq79_ajs8zFeEI@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>

On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> Ian, 
> 
> I just discovered a strange behavior on linux 7.0.0rc3.
> 
> I run these commands on my x86 virtual machine:
> 
> bash-5.3# uname -m
> x86_64
> bash-5.3# perf -v
> perf version 6.18.13-200.fc43.x86_64
> bash-5.3# perf stat -- true
> 
>  Performance counter stats for 'true':
> 
>          1.108.929      task-clock                       #    0,437 CPUs utilized             
>                  0      context-switches                 #    0,000 /sec                      
>                  0      cpu-migrations                   #    0,000 /sec                      
>                 55      page-faults                      #   49,597 K/sec                     
>    <not supported>      cycles                                                                
> 
>        0,002536439 seconds time elapsed
> 
>        0,001363000 seconds user
>        0,001393000 seconds sys
> 
> bash-5.3#
> 
> This is the epected output, however when I use the perf version 7.0.0rc3:
> 
> bash-5.3# ./perf -v
> perf version 7.0.rc3.g1f318b96cc84
> bash-5.3# ./perf stat -- true
> Error:
> No supported events found.
> trace.args_alignment

And this last line is even stranger, in my case I get something else,
also on x86_64:

root@number:~#  perf stat -- true
Error:
No supported events found.
addr2line.style
root@number:~#

On an ARM machine:

acme@raspberrypi:~/git/perf-tools $ perf stat -- true
Error:
No supported events found.

acme@raspberrypi:~/git/perf-tools $ uname -a
Linux raspberrypi 6.12.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.62-1+rpt1 (2025-12-18) aarch64 GNU/Linux
acme@raspberrypi:~/git/perf-tools $

I'll try to bisect this later, thanks for the report!

- Arnaldo

> bash-5.3# 
> 
> Same happens on my s390 systems (LPAR and z/VM).
> Is this a known already?
> I guess this is a perf tool issue, same result when you execute this on a 7.0.0rc3
> kernel.
> 
> Any ideas where to start debugging
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
