Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0D1C69E
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Apr 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324785; cv=none; b=K3oNbx+HoSr+6C87+cLWuHnvnyUHlmepvJLfI0rbD5YTrzHyfhvs0o/ra6jW2d8+HIm+kBHarptT4vWAUcLo5ZDtQxS8uhBGWLD44pnw3KNlZr0DPMRzXgMuKUCkeuPx2aoOxFgItPwOUxnr3Icu9Vw/592LhReT+nh/Tb5Om+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324785; c=relaxed/simple;
	bh=LyomGSHpdEgGOl80a2ldOlKNSIv7PlmmHuPamjM2pEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSvHirKooAo8zD3o97yn+bPQNdUd9qJA6XX2bccHDp4sBuPuglvrhdqwkOI3naUCdjg+9D2jhXipsDhI1DbJPhcx+23E1InmsyRcLd+eudZWpbDaVcqhwFkMc8CMW2WKfVp2DH0tjF4+F/12v5KMKKT64dLAtWCVjwKKoe2b3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klKBvg9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klKBvg9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724FDC433C7;
	Fri,  5 Apr 2024 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324785;
	bh=LyomGSHpdEgGOl80a2ldOlKNSIv7PlmmHuPamjM2pEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klKBvg9gbAp9bsKqH3vOC1o1hCEFeeGQC2Jm/sxFeWiXtptSIhqdtBx9r/ozPY0rK
	 klf0a563VVkrgzQjmXnuyjC/DkKXk7bHW/ZJiWyfOuAUlFeP9hMooYV+rZRFJsUWlh
	 +Pf4TwLPL6WBHBUqyOAkgyzdFwbxY+AQblxmwRpAvTkjfsSF2nFewkJS+rr2sSxxtI
	 43vWh5cNfHP2BMILN4yAfQlJB6QRaZuZyuk2dUUNCtJXGauoqgg8w/DwdvGN4sW6eo
	 v9aPwnTpVGu+AiRkeQRA1WqLMrxkuM07fUkmLwV73KQp/qxX1RPHE1Ii9kyKU2MTEL
	 nv9r+wXpW3o9Q==
Date: Fri, 5 Apr 2024 10:46:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 1/3] perf, capstone: Support 32bit code under 64bit OS
Message-ID: <ZhAArR7BsaFhoi61@x1>
References: <20240401210925.209671-1-ak@linux.intel.com>
 <20240401210925.209671-2-ak@linux.intel.com>
 <3b60c8dd-32fe-4dfb-a78f-8596b3ef4410@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b60c8dd-32fe-4dfb-a78f-8596b3ef4410@intel.com>

On Thu, Apr 04, 2024 at 09:22:11AM +0300, Adrian Hunter wrote:
> On 2/04/24 00:08, Andi Kleen wrote:
> > Use the DSO to resolve whether an IP is 32bit or 64bit and use that to
> > configure capstone to the correct mode. This allows to correctly
> > disassemble 32bit code under a 64bit OS.
> > 
> > % cat > loop.c
> > volatile int var;
> > int main(void)
> > {
> > 	int i;
> > 	for (i = 0; i < 100000; i++)
> > 		var++;
> > }
> > % gcc -m32 -o loop loop.c
> > % perf record -e cycles:u ./loop
> > % perf script -F +disasm
> >             loop   82665 1833176.618023:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618029:          1 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618031:          7 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618034:         91 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> >             loop   82665 1833176.618036:       1242 cycles:u:          f7eed500 _start+0x0 (/usr/lib/ld-linux.so.2)             movl %esp, %eax
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> As with V4, comma in subject is slightly odd, otherwise:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Also note V4 Ack from Thomas Richter:
> 
> 	https://lore.kernel.org/all/5399c3b2-a1f0-41c6-ba91-a6a6692629dd@linux.ibm.com/

Collected Thomas for 1/3 and standardized the summary lines, thanks:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -3
0209991d98e483af (HEAD -> perf-tools-next) perf script: Consolidate capstone print functions
d812044688dfe73e perf script: Add capstone support for '-F +brstackdisasm'
38ab60132b0d477e perf script: Support 32bit code under 64bit OS with capstone
⬢[acme@toolbox perf-tools-next]$

- Arnaldo
