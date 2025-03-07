Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DF19DF4A;
	Fri,  7 Mar 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373745; cv=none; b=Qfs3dQv+S+asq9y+VA3gcWjGbuxGDnxUtOAZmW4D1rVsNThs9SeaZ6XK4X5lKxPLL0WmFnCCLkaWujib7eObo8EU4h/vAvEyCmXm8OxGXuz6pLpKqyJCY8P6q2LSVIeM1cK5EZpzKoq61v3RIWWgjQa/r8CJzntBxqMCEKvIX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373745; c=relaxed/simple;
	bh=86skbsONZGZP9pjLi6lZ8M36onJpc2uZLgQpDZ0s4Pg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pMmeiHyJvDGAg4TvuXS8C50i9z71hUh6MvIS+brvF3qCUz+6iHeHzvl+nfbjvg1oqZK8LJpKxvUxOaoS51yuDm+CjkF5oJ7382tSS02PbMAlzLlxDfzHMYTeUGrI9qpjgJ5/y7BHO8rfnVwt+9Xgt+10rDD1+E8CJgDeb80TdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Fyjumdv4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Fyjumdv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741373727; x=1741978527; i=markus.elfring@web.de;
	bh=86skbsONZGZP9pjLi6lZ8M36onJpc2uZLgQpDZ0s4Pg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fyjumdv4cR3D97iNuNEfz6ezQHo9QULwNQ/9b/JAHStESiHf0rKiBA/JNYBT1WD3
	 1h0W9CiGl+tAHVNBhbe2nOHRLdTQwScpC2Dazhi1X9uaODsOxaPeIWxC0Xf6a4gwe
	 6MJsblZ5EyGBbyv7nROdo3PUEsbEG0sYZHmvEcdjtGQdADgjIaOaCqgS+cOthCkyW
	 EaiiTYFDmbJ6PTo1nxJ2Yu+oE9/NPQvcyoG0pOBNzuUAV2aAd8yCSzS8zDV4XH+0L
	 /4NpuiC3UFkchlWUKao1DsGfr7wCtHzzPsv9QDuYZT5EQqon0OLDoa5/O369G3hif
	 cCIhtM6OptDq8GlO9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.70]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1tlvuY3DQ9-00Q2IU; Fri, 07
 Mar 2025 19:55:27 +0100
Message-ID: <2719d1d0-6e1c-48fd-b73e-42b78c51b201@web.de>
Date: Fri, 7 Mar 2025 19:55:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250307061250.320849-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 1/2] perf report: Use map_symbol__copy() when copying
 callchians
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250307061250.320849-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bvCzD10uajwy/qZSnyTYEOKCpaqXvR5T3faQr5QFSHEZIk+8Vz7
 UA0dYS+Mq+dd6ZHCibcTwaUj2k/GtRIRnhjtqNFx7/b7QUGIwJzTVhWQbUxVDmy3ovm3w1Z
 QXZHxhxdFe7zTc8SA4mvDliGd+ObB7LKQ2jrkK1uR6Dd8cheGslj3tpwBJBFmiy0l/AdEQb
 CPdeuUk6LudrKBYzaTLwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Q5jl4dEAJI=;XitBOd1LjkyRpHlThirBb3hEBnO
 Q2NYl5NmQqJ35fdlG5E9BvYMZAfj1giDiocg99WGUIvXjLbCTk8nJR613I6+Lhwg4cy+5tFYh
 A9zaKc1PreA/6RUPIeNg8DoEc5EYg4JplWQZDyFPRc2aZqtMwXL9DSN7+RS7rZFFcnY2GZD7w
 eEd6YfDMq+sMFAcoM70KIjaZnMLKosjXnXhizt+yWtgkAoxw1ktuzMB5bufBva3iFPcpSFq/2
 RodY8zkFOvAlozRPALc4V6uU28SyGm8CfBl4XBeT1mg1tjVRlRcvPs2m0htdJAU38vaYtZPxy
 gvgChwG5RKdbyNvuCgNwO7gFDuHwxSH14ci55lJhnts50TGfOGwdAUNcFQFyWoOKW2x4+qPgQ
 G3SMeMo9GyzhGac8Z+MdwdfcJCvMa+oSdn5TJrwzEkpp+QoTdw5dvgrhD2CDVk0tvhF1qdnEd
 sXSCfOGONdIQHg+JVTidlkgO7uNXwJL0fNbjAH+hJ5fpZ8lA03B/g250ixD9BdoLX/gP/BwlM
 gsTsoDa2mf9OZ9zLv5WjjYkXxtbEK9wf8Oxmw/2ps48VbstJQeLB6jV/rArhPWb30XDxIiy+P
 9y1udlzOXMxZMzFNjBRQjjdR2bfA6xeOT0Ne9C/ehwIeUMDyrILvdvzGJ0nsDJuxL44Codbgd
 zJz+f+HiRXbd4F3x6QBZBmmS0otvr9QRRiPdewiL305pA1l47Z/6r7aqgkQp7I1KfSAhDE33j
 dR1jthIZ5mWEQCASjdQCfA9cf8G6ifXNawvN3kGPuoOMiV7hLYUlklyjBj5BO0oxMsoMkqznk
 M+7yRwsrSCfacxC9v2Q9WBSph6bmdkiGIRHqgPeREGNFnZyUfe0uFrdGXHD8KIqQTMMugc80j
 Ve3PuMuDPRl1E7isWAxn7QKHmumu3kFExoRk8jxG10AZddK99PNV7gkXqc4RnfHniauP0afH3
 swnNQwrfmFrqCszVy+4hH4xDzKzDG0FINq7jd2sJXVXhiSXtNa0aW5x7x6gM0O/MY4Jm+7HG1
 yFKa2bW6ftwdxGjQRg4ULkCCwikQHDd/wd5NQ7hszYRgWLv32LUvDx+XL4TCjetRZGA69QC/E
 On47YjTQLF9bXBLeH1TI/l+cI3NUsAcerhFVJCGZE+AKxdtsoT9LtHxQi9784gaTyifR+pkJf
 0tzlIr+Zpr0K2Mw5+EtWrroFiF/JyRxDgWFcU3tRFRCrihbZGKCiIBa5RqW0v7PZ6KYOBhmfG
 37F76q1Yu4Surjb6keBc8hBhnYuqNH/2xU2ELOcdQoFm5ljzG6wO+l42T2r1zwmL46hgWnbdZ
 hlaxMihMsmmP0j2Wusbl2Vt7g0TJCENUMyRnMQKFKe7xYYmXfpp/zvX2bYYKej/1nVU3RHzL6
 /7JPQ+vKon1yQUwKeSHGiE//bB+wyUYkVliq2k2YoyXcvaQJeMp2hlWgVDzNhSE1ChbFgNmmb
 h2NmU5g==

* Please avoid a typo in the summary phrase.

* Can a cover letter be helpful for such a patch series?


Regards,
Markus
