Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A9EC7
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960385; cv=pass; b=ooJBsF0Spn6Tk+y3LEfqKamweXtcofvV7fx/JkCC5HZRv+CsqIMzCWBqW/acnYvgRZZcGFI25UugIhcf1AktC4S7t7mh3hYsCRjOONvPc1MfcN3HJoL3z9JS2ZRlFwDX5eS4ejPeZuErQz4Etc4ANGKpsDOjCnMuY5eYRcmdu5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960385; c=relaxed/simple;
	bh=nIMTesr1v1tBa43WyNJy00tk9dfQLaZ18mnT1dDvA6M=;
	h=Date:MIME-Version:Subject:In-Reply-To:Content-Type:From:To:
	 Message-ID:References; b=Km3PRzSwbAsbGPd6ChCapj/Ci3MkgsEDknnRIsIZ6FBJqylY0c5YcstOEchf8Vu1hQ8q4BnFhtKKNhdnoIzL4qGeJunk4XdYvirFD1tPPEWgsHUtL7kNB7IpL81sEQaA7ORdpWeDPtLjSOic0tSlvDUZbkxoroO+fnkGF3DtECU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me; spf=pass smtp.mailfrom=slmail.me; dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b=LoQbVd8u; arc=pass smtp.client-ip=176.119.200.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slmail.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b="LoQbVd8u"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1721960017;
	cv=none; b=I7SKzDbGnsZNC7k2Ar60CCsyZvevQ5jcMHHJS0elw23PW68ClulPy5wjRAOp0xTfgvwHi7Zfmkt8l8u8hN1gpRcHF0ot2y/QRLbpw9dGhQavoCSG1APVGI4TCooBq5B8+j4/r6iSaCtxiadQwqZmmh7DWR9C9yuVSq5rZ8ZIDhc5oGGqPLBJSZX7O0YYMbsq1MJDji4YiE0JCSooZmPv+HwP58XmCR5EPqqB1Tmfth0VGnUwE/XwncMlB2Hi8xrsYpoxERHJy5FWaFwQCkiE3F33VXMCl2ZBEpWkkmTRJTpoDL1v9ggCiqwW70C0XTSb59DvwPA9wPiTUE56AnnS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1721960017; c=relaxed/simple;
	bh=nIMTesr1v1tBa43WyNJy00tk9dfQLaZ18mnT1dDvA6M=;
	h=Date:Subject:In-Reply-To:From:To:References; b=fHedmkVW0J9TTQqBCP2hRuqL3CXmU9QhAgHVFOAPLathb+AehhjU+ANxmiScDPM3wV+X5De4VjEaQqpi0I7dji5qmp3lOot+yPAjVlN/hMxsajU/fiMTlp9KO/0rwaibNB93koeRtkToE743nR2PmwlUPo6n/zwaHgMv8kro/ksSJNApIiZlLcYcZexil/lZ7Fz+ZoHbXyCY0ydAfkJzqFigm0N+B+FpuhMq7L3Ew/uKsxOxSTUo5DtNvmzd1fIPWGwXssi7nxzacppq791lcdLFr3gnQ8YY7yq7kRrdzN+4HOLlTdoeItQJOo7SAYwhvSz+ezRnEtp0qnWioilEEA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slmail.me; s=dkim;
	t=1721960017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvL2ykebGtqTpa72vw+KDv2ba1jYNWo9iaaDhGZLPmQ=;
	b=LoQbVd8uVeg5oyTK7BUGiWrg5QVYCXkW/+HzC+VE4ZRkhudvdsRxZTokWASpxuOw4+5cuc
	9Wx8tutODFi97DN4dj4q6xMtYHuO3xaWD5q2mh6aVIh4OBv6VHoPD0GzOddabwM0Z0LdLx
	mvmv0CHhTsnSIRaejshj5fgxUO3aDDU=
Date: Fri, 26 Jul 2024 07:43:30 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Perf is crashing inside Flatpak runtime
In-Reply-To: <ZqL6z5WwJKeFf9FW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: bbhtt.zn0i8@slmail.me
To: Namhyung Kim <namhyung@kernel.org>,linux-perf-users@vger.kernel.org
Message-ID: <172196001664.6.11995879867204963322.389309805@slmail.me>
References: <a69b8aca-9b37-4a72-a657-f708696c192b@slmail.me>
 <ZqL6z5WwJKeFf9FW@google.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 389309804
X-SimpleLogin-Want-Signing: yes

On 26/07/24 06:54, Namhyung Kim - namhyung at kernel.org wrote:
> Hello,
> 
> On Thu, Jul 25, 2024 at 07:07:09PM +0530, bbhtt wrote:
>> Hello,
>>
>> We were reported by a user that perf is crashing inside the
>> `org.freedesktop.Sdk` Flatpak runtime.
>>
>> To reproduce, please install Flatpak for your distribution [1] and
>> then install the `org.freedesktop.Sdk` runtime using the command
>> `flatpak install org.freedesktop.Sdk//23.08`. Then get a working shell
>> inside the sandbox using
>> `flatpak run --command=sh --devel org.freedesktop.Sdk//23.08`.
>>
>> Once inside the sandbox, run `perf record -v -- ls` and see that it
>> crashes.
>>
>> The output and a backtrace is below. Any help is appreciated. The
>> downstream issue can be found at [2].
> 
> Thanks for the report.  I tried to reproduce it with v6.9.9 but my
> system worked fine.  Is there anything special on your system?
> I guess you're running on x86..
> 
> Btw I'm not familiar with Flatpak, does it run on the host kernel?
> 
>>
>> ```
>> perf --version
>> perf version 6.9.9
>>
>> perf record -v -- ls
>> DEBUGINFOD_URLS=
>> No PMU found for 'cycles:Pu'
>> Failed to read max cpus, using default of 4096
> 
> Maybe this is the problem.
> 
>> nr_cblocks: 0
>> affinity: SYS
>> mmap flush: 1
>> comp level: 0
>> Problems creating module maps, continuing anyway...
>> No PMU found for 'cycles:u'
>> No PMU found for 'instructions:u'
>> No PMU found for 'cpu-clock:u'
> 
> Hmm.. no PMUs?  Is it running a guest kernel or is sysfs mounted
> correctly?
> 
> Thanks,
> Namhyung
> 

I think that was the issue here. Flatpak mounts its own subset of
sysfs inside the sandbox and doesn't have access to the host's
sysfs by default. Giving it access to that with
`flatpak run --filesystem=/sys ...` seems to at least not cause it to
crash.

Thanks!

- bbhtt

https://bbhtt.github.io/

