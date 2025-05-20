Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D90276054;
	Tue, 20 May 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757523; cv=none; b=rarZ2hQfIZool7de6AyDLFRQJRdCt0mKGY+TSWiWPSiYt5+9jk6JBpkmO7VKpm1kb/tjDoPkkD48RSk4NManvNLSMmpOOiQKGW9T0d28c1UaiasIjbkytIj1QLEka+VYGoV8ngGWWP/stH5CfhY9GQP43bAq/jq4Wwu/qbOyTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757523; c=relaxed/simple;
	bh=U6lo7wpJePXrQN+8jqAd6+6cxb+SFV2VYr+GvxVd548=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqAIM6Hw5W/O9sgBvOsHO2Awj5Pa6Fa68R6lxxrMOK9O5rniPYwpoNmFMWnXLpiESdVaxBgUD14GLd9pDQFDtQ/kHA8h3A5YobWBGJa1lQBo73j9QltOFpPYFjtjKoyZLNrYURORhLl1Kte8hR+UIQNLDE9V78339yK/jx2wZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dMMaR+AF; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dMMaR+AF"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id HPQYu9zeCFfBZHPQfuCi6a; Tue, 20 May 2025 18:03:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747756989;
	bh=U6lo7wpJePXrQN+8jqAd6+6cxb+SFV2VYr+GvxVd548=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dMMaR+AFCHRDRqO/p9iL5eji6THqnlwGIZf0pOLqdvEGZ76W4qhMTn+EiagUzdWxQ
	 CPytae6VjbfmGmLazR6+oB1RU1rhqxBt1Z7DKF4xxVCUDXmf1cpRc6UvyrT6rwNAbZ
	 n9H2RMmZaDVOECX0m/P5L7y9wBPZZvgiL993jini4zAjlyKJjscVr9e3XnujHeOyxj
	 PPJU1TFkfamk71h0rw3hVUKHM2ITkdhzgDXEIMvbi9pXjqE8acGw8o6b2jfI0Qw1oN
	 1LMgj7K/GD1Gapjq6CGwjHJE3SCvoujZuArtvIQ260vmRZuCWJaFE3kpl2UWI6fe+O
	 Vse/wByRNa1Mg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 May 2025 18:03:09 +0200
X-ME-IP: 124.33.176.97
Message-ID: <5b83c1b3-6370-4df1-8a57-7940d7a629fd@wanadoo.fr>
Date: Wed, 21 May 2025 01:02:49 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 I Hsin Cheng <richard120310@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peng Jiang <jiang.peng9@zte.com.cn>, Stefano Garzarella
 <sgarzare@redhat.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Yury Norov <yury.norov@gmail.com>
References: <20250519214126.1652491-1-acme@kernel.org>
 <CAMZ6RqJUf=LpczMNu9WwLik9i-4tJHYENvM3d15nxjNM+_vc5w@mail.gmail.com>
 <aCylQUlY3W7rbZAs@x1>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <aCylQUlY3W7rbZAs@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 at 00:52, Arnaldo Carvalho de Melo wrote:
> On Tue, May 20, 2025 at 09:44:05AM +0900, Vincent Mailhol wrote:
>> On Tue. 20 May 2025 at 06:41, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

(...)

> I think there is value in doing it now, as it clears up the build
> warnings and solves already one prep work that syncing would entail,
> namely the inclusion of const_true() in the tools compiler.h file.

Ack.

> I think I can take your "I am not objecting to this series in any way."
> as an Acked-by?

Sure. You can add my Acked-by to patch 6 and 7 (the ones in which you put me in
CC). I did not have a look at the other ones (and do not plan to do so).


Yours sincerely,
Vincent Mailhol

