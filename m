Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304292E7BD9;
	Mon,  8 Sep 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318550; cv=none; b=ct7vaPqWHWVCf2JpZvViVHX3F/w7DBq1NMmd9tbuiBkcmW+0eGeW/8AJuNnU9kvPbAzNg8gzu6LZ2LHozchDqthWEG1EmWiU6yr0Nh/oM4Fro+7KBa1y2IZZpXSZi80lE9XvDxMsMKkqgV2PwepXHT/NHrJaBeDVLGvMamEBPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318550; c=relaxed/simple;
	bh=3hwACGIQH0jr1hEcbsqm2Ue6O4U2SxH+oQssuZ4Wgow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYnNS0J5AfmYiAFLISUO5xNe31+Ukl5btYnqj1qCOovM7rBN9HYg4b5jgcSAsxlFDUdm4YSn80NC6ymLjSM3D03cDAFa8pAyVdiZpseZrJ/IhQMfgjVAiSA+GqOXiX6fiLBUlncWX1o8hRum/GqjcADlUwKmkPRQyo6fv52d4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vVcIdIbN; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vVcIdIbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757318541; x=1757923341; i=markus.elfring@web.de;
	bh=gwm4KSP1GCFHCX3lYP5GOXMNZy60bOd15PsB83Zk2vQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vVcIdIbNhApAc/+ecZs1vUTHSovqLDvXWdy27dBF+hAFobIS2JADHZQYUEJ5R9Gv
	 6SeIUA30wfZoqwUlpp2ropyFj74haQHxf2LA4jcrzUsdLrPzlY/oz4ltQHfecm9lZ
	 zBm5wnL8y2CIhcx4kH181mxtRxQszT+dCQf8KcvZyvi9Zj6YbPTJTU53V21LkRUwH
	 IjLQKKDb8nk+gAzMBsSJ5pyhiNLbiaunrE9JvzmHoN2tRRPo+EfMwhbyCaS1xg0Jf
	 F5Hy3PUFAg1WJaOZHdI3UsxwpOfM0mIM7VOKIEL6u7K3l7NRMFXMQNXrncHeUp6t5
	 Klxzh612AJWqpuAYnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.229]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1ujizo0g29-00DZvn; Mon, 08
 Sep 2025 10:02:21 +0200
Message-ID: <947f8359-6380-4285-a593-55b3414ea86d@web.de>
Date: Mon, 8 Sep 2025 10:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf drm_pmu: fix fd_dir leaks in
 for_each_drm_fdinfo_in_dir()
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250908065203.22187-1-zhaoguohan@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250908065203.22187-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4yT+11/jY+tECS1FfFAxf74SDbmXDjSXlieb/EZaJ4D6n+XxO8H
 k+xvBG3SILybnudo8LOuoV9LR/r1n8T6wh80Xg38EkmsHG/bhr+f+RFyvUB7sX1vIl+DBEh
 IpTYGrjE38cZsPEVqJtrSxLpMuovjoeNTgH42MysZohzTcmW8FrXSuZsqiVbpSHAu/IGM/C
 09leOWt3xFjMtB8Vy52oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:phc/N4RCZjI=;LkpWrPMbmb4z/r0/Oz8RHhEhpyZ
 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

> Fix file descriptor leak when callback function returns error. The
=E2=80=A6

Would it be nicer to move the last word into the next text line?


=E2=80=A6> +++ b/tools/perf/util/drm_pmu.c
> @@ -458,8 +458,10 @@ static int for_each_drm_fdinfo_in_dir(int (*cb)(voi=
d *args, int fdinfo_dir_fd, c
>  		}
>  		ret =3D cb(args, fdinfo_dir_fd, fd_entry->d_name);
=E2=80=A6> +close_fdinfo:
>  	if (fdinfo_dir_fd !=3D -1)

May a repeated check be avoided here?


>  		close(fdinfo_dir_fd);

How do you think about to use such a label directly before
the function call?


>  	closedir(fd_dir);


Regards,
Markus
