Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D8341AA0;
	Tue,  2 Sep 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832128; cv=none; b=BNnUzMaqk1ZvMVztD5Hq+MGPW02+o+s6y59rnM+kYhf4fsgwT671Khv2YIX9AmEJ8WMw1TpOCcRw/7RS05OvbxxHg90jd0pumgMnv5AIu0a04AEE4Tv9DZ5YTgkYIpQZoqsiwkKb7bQzB9DaBao7KQe7ycae6hq6EIXXKOGOg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832128; c=relaxed/simple;
	bh=hOXIjXDcHemoDuQVpQfH4FLHi3Dx3YgyHLSPWbJksbw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C3Wdzzbk3AdCX70IWEsO6oJrhWBPwAQCl9NTgMXL84IWNQTNVoTW3WcVgnAiEUDP5/iwKQIkWGeYJUhzg5erLkwcxfN8zgFVp57+m36Pv/3A5M0OJJiUFXPmMCwb4padQiAgIxq039Lcs8L18aWBqW0hQfStqkt9wxTok1jWT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K8anpn03; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K8anpn03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756832096; x=1757436896; i=markus.elfring@web.de;
	bh=BqH/yVnzvINWl7qLhs3lEAi4WytCsdI+N7zfaNpCiNw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K8anpn03MuWYsZ0i9OKUQ9XDEwnioTRjbW9xBL4rXszbFFvzY4haM8958aELYkJU
	 7vuKpOzg0jGX3yjg5lDtY6vv9AEhn9f89VM0FghzkF487pMnSFVLcrQ7M17iawhLU
	 7+s42vjGBeXTYhZJOILWxiiZ/LYxJ8WiQMFUB8wuEWcLR96D2dIP/eW/FCFPogXT/
	 fEKzvzPK/oKE9oeMGHEtJkddg+JFj7KyHNcNcLgHWR2MCwyf34eM2fiT1B9vVxzNm
	 VKK9J1H9OQ3HM3F5n3IvZ/eNcf6TKd/kWDicmXQjgpCIvIVb4cvxkDTZ7XqlBI21U
	 u8sfrRQo2cwvYygvDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1uY0A307aB-00vMan; Tue, 02
 Sep 2025 18:54:56 +0200
Message-ID: <eab90856-7066-4de9-9080-f2479225ad00@web.de>
Date: Tue, 2 Sep 2025 18:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, linux-perf-users@vger.kernel.org,
 x86@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20250901131714.646988-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] perf/x86/intel: Use guard() instead of mutex_lock() to
 simplify code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250901131714.646988-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8YI8hO7Q/OKEl3TxqcDjT5ieQ12+4nnLdngSGziaDt9yDA9twBz
 IvWG3LvtJzmiH9mgE49AMzmG2ePykFzVTCCZQ8PttIyqMYkdYoOOxLl+PmN74SP86OVObjt
 3Toigwfj+T1GMkV1jEfLBhhPhiGeKGq/ULeWBJn7AEhDdtRaoY7yorO8jrHXRjAtWhjo9Al
 Rr4wzhVPnaHEdsMq6WWTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/qmT5/1JdzQ=;qQUzZ7U4N/nOc11zFoOpiVPLIfZ
 kKdcGAEsH4fj3kz6ACso6LGinx0v0BAKmHHUQGQAJSeMWF+m4Jj3rYkqxbGQi6xI//l05N6zj
 IMzUo4IgrCEVLJnDkSbVb+QYDvvaUDbu56Zh4IEGKyFs8k0VugiNv6vX5C5Xn62iZLxJz5q5U
 1Ksby3P+cSLBDZFIU0hCTOZY36nZLvNvt34L69UtoISWGm/Dq6yO9+uZNnHS6eEK8Xlmjeu7Q
 Vl3/FUBbdi1xDIaDXBZfJCGNGbZZnJ6YvhYPNf092ocoGjZz/clTs3y6oN5yJkMkJ0LVQhJvu
 obbkkjon7J7W0r/oAJC1HfIj/YF7QxkXfMbUHIOfJz2L8PrZujpjJptaORL9ueLpaA/ymErk5
 L4EJYPyUli1A2tDS+8LlpTENlpmiASIA70sFNlDEi7sWDE9Or9/1msX7HWpLIZ+24Me3/lM57
 ICGAddaml769vri4Oc4KTI0nPOJ2aemz1pOO9SI7WXJcQiSfsa+q9Xv0bFMgdST8BPg9y2LMV
 14RBOC1lbD9XvucoHzjxyDmBAJWZvEFA2Up0f8/ZOcf64K/86N6aku6Qdqi7ENGxnB4tUWDTR
 edBon8hAI3N/+zvlpWYrHurD2WgXyQ2HPHF7IzpTA799graPYGSrV7q7ydZlUFzR7dZ8iX67J
 DeLWJnRvg+U9gCJzixdLxeirZJUHxlak13x6y63vHDIU3uJCvmhdepu0wduwEf29McNARsB4r
 jGYP/vP9UUOIDVwERxxS96OqGKOfZIOhs0BnGQwFMBHomRhSU5f38qrabbb+p8BMn7+a7BWWv
 B+TImOgg/zTxj3y/AaMuin84Z37CoeP1BVrc7VMyNkNff+4g+XYDoobfL0KvQlnr5dNWqhL37
 2iT5vGkrCisDdgiXhUqNV8rKVgyimyBrap4OAPg7fsgzBjp8H+Tg2BGZ7bnDob5zPfl4aLMor
 Yor3q2xOIB8IbyslxYNJiW6DTytWGcWG7oFQrYUDFog1pb1xmgsfXbWVNbiW20VSjbVcJLtLt
 dFcaGrChb7W9uD03smI3YFNpO7oHEcdjfhxxdyq0mpvfvBhO8s8AWIAtlNWDm5kbNPddi5Xu0
 OcaNtjVHAT5PGRIo2ICCfKh1oMI9dStIQ6/EfYEhB4ulXwlZd5Si8mORb4lp4FhDrWKw691vB
 zCRaagk5Hh6aHM6D2bwbjqRvNLp4qjzvJaM+fQ6/yUHAnzG1luQ8RyUOWB7DRczK1oqOXw6CK
 QZEb85JwE0NiweLmKw7WahNNnnJCpKuxPLPdfgjEehv1sm/zB0k44G1fuYbP9u3on0KBAUANN
 rUhqvfecOVLdFpkePqMtIcgMUyIJxYiwI0iWrh5xOQ3JMbmPnDNm1NkvJRD9n8CrbEcwYM9xA
 CtJ5/Eb1qXiHYGxUY0ZoE5tfiQrm40K5a44bs0X64Wc8gXj7QPaCI2YSP/ZNj27sl1Oz8rUea
 qSZ1pveK3rg5R1rXcW+JLyWJmu5S5dGqOuu2BQNP67F2azTrfa6uzWcu2gKWyc4LmI1YQiPbf
 6/Vb8xHj0M5lFSk4FNLLWCTJZNza7a7Lbkcmvei8MrUGca16yT9/OT0O22FSH5p6iB29NObTX
 pLdN77H8o3HmtztdfN1gL+TznElC5J7s+LfCrK5MbH7cd4TF6PAJsMP8oMFIrwiunAIZSQA/7
 u6Ae6YNugOi0IUqHQH2isS1reDdAIoF7pfTA+iP/vGWvhcmDXhB8VNIbfJF7EQ/KrZpPjzMEI
 XNcjAN62Iy7iletGMdlgOoDC0mOBUdLCJqJrUClpZ49fMoEIsotov0ibTtVDuBefidX6rQUjf
 GnULnJt2Gp+9lIyb5zG51gZbom5HMlesUyMdSY6ioEyYhV+7+FiV5XQCQZqI0/JIt/gZH7obE
 8Be5BUqCAsom6KD9k0843cTaqK53kdbgJMeX6/+uU4ze144WcHohYVb4KOgKV0IrlEhNf39kw
 /UdzzXHzObkxddGMEB+ZEHnlFiwO0fKKts+jSYVukiyAK51h0/NLWhBqlDyw1iw0xOtt3UOd+
 2TuxL7gpYc90XPRfPg+8RkLMGa7Kw0K77oDq8IbflK/T/SXamybZJ5z0wO0jb6DgmzWqZcGIw
 0uyd1AuxR77z81x0DIJe7/Ks7pX3krvOmRXY8p8T/FKtiYXrvbgNclrm13Hm16NUe9Ojxja1f
 srsQofW/VooAjCrrcjZjapEVQEXzluroyjneVM9DTKXBaX7kTXVfqHasUdGxLJFjcsB8oN9GN
 uZE+BPmFaC8CFahsUiXUXFOLhNzCy60Une1a5dejdBzhjwjeAuy3UGg1SEdx/ESR61CCG/K87
 p8pKFrzbSpwJ/QZm5O+JrMMAJaZGvhS5B+8K55o4ql4HCgxp1lgrfWaJi2MpwXuICB0DN9Y7f
 dfrwV3Z+uRDyrME51UDdiyu4rLejLAGQKKv9/U7UYYzQGJIPVYaVrhZpa/m77or00X3iY27Qm
 vHEhu3cViC81vDXqncBGQn8j8xrDnHrdiV0v4SESO38zQtr4a1HOl1PtDrzUQsirZMuCgY9AI
 d/VzZQ32Aalyu5IzP8+e8dQPw9Hhq2PqYxecvVcUkfkYuiibMMEfc5FHT20jjKo+53jF7Tw63
 tfHy0LcvfQkUj1yh6KwTrNMFYhuHWKkDYq8cdQ81iWMv+oQnC1kARzJFbkFPV472X2QhuALF2
 1LYCUhbmjhult2mqTWy/+LfY8+gU5Q/8pLJu9MsfAxCXOBfae71yKrywn1zK13TGu1fs8rZ+D
 INO1pRlOH/yILAsj/SwmTkdoKtgHun27Gu7Z1Nchrj6Byie9Fx+X/+pos2WLRXlCh0cnWVrZl
 C/kHnXbFUOkEMjag5aVI8Kraij9K6VHnax19a5l5nSe5ZhBxRUv9p7+ftVl8LPshfIwcNzesf
 8mKJsbaKMFRgFrlTDcVXWa2y5K5+hx+wKn2zvU4cHUl3ULv5cqpnkkqNeditWnsRI3tHmRLz9
 fbjaLcfN1rZikZr043lUOxH7OxaNN+EkGtouc5KdS/Wlu5/ViuRJvBlTNLM7BB/hw90ACjXcG
 Zw+X1v2lWlxZzEXTadWBd0sZzNYxcJW4N7P/bFWiMbkXikuIR/f35d+68+MYo5oDTMPYFdNnr
 uCALmrf6pnz20agECz6a+tnZxGvvZXwpW53jnavxxn/5/oDSXswd6ot6v4YXWk8DZtBU2njRa
 MJEFPWR5RHxZ3KgYoF6/lIXuAVgkc78kpEVHEEGwsX4Z6w4ZY7O9Q97x38L6TdWZRRJ2XNk8b
 8m6heMlEU7PN4PrzcDm/fXuQ2huI/aPHuH04v06EGTWIoZ2+G1VZoY8RyqO7F3DoP6HRAHVDt
 12AC119QqB+t3Do8mgZY96gFsJ/l2js9iov6ovoqhAxfS5+ICkEpG36wSLM2zbDZnN1vHMmPH
 W4eDkv2lZEjOcepvUL/x35UvvHqaEqWlHYPsmuZes5P0dLODnW2rEIG6enqiLST0sO1p3TEL9
 w9Zkvg/XK1gRNJGdIg3gc1ZuVENSUEK3K/TqE/NIUxrJqe9FW6oGq90kIpoM3XrXXuuIwcejg
 3IJcZRpItjQy2clbcVCQ5g//VJwluYGF1DFrfJTIqFLPa/iCFdmR5Zo0lMBgtfpwuHB9jxlYK
 ZSrvEVIqFK6xTqmxQuEaApjeCO2I1w3sVW2nayDENHBwFq9GzEHoVIpSdD3NKpLG8KIPPqhaF
 8UuU6DDvVyABynhwrXBTo2gwVK687tndzuGJvw8CUo3cxHlO7DXvK2g1CoFx4Tt0et0n4xofh
 DqMUVPw6cfdJgZ1nbeZAGwFryb8xgiKKbv9dq2iKei2qU3mQe5fBvGrC2SLmyuyEJ3wOsFGrD
 i8tF7+2dLUvgWRWcNK0L2zCm7r/Z6p+NJ8R7FOmksOpoplSasJKe3XZeiDm9x0ID2Mk21+WOz
 XpA/i9G/m/y1haXX4+iDRb0QeHaixcpx1aS+WZRcoRbWIG46j38xBcPBUDm7U3+cgQM2tn07c
 NCxzdnAcoHXv1EXDNDGk2jaMroOttRIJlchGilk8uwsyfqYFa8BWeO0AzC3MMNCasDZiNPYB8
 yuX0GpBBbScyr9+Rhd37EDBFY2XvwpBlR5JGIK1UpBkq2qp3p40t02B0pLF+UxadLL0TZSA/6
 zef4qozxw+l1oUcMI3TJPFJSNlj8pKVLYmf0GAoqHkXdg6TwCMLOlTX64MjkKbQTwdxKujMrv
 YY8L9HtOIwizkg30nXaiAVPxlcR+R3XDxKeb2kQDA01cmyYT+z5N5d8BcGUhNU7yVUYeNnKqA
 xgFpBGarkrL/XMH1hL84HF/mMgn6ivBgGlIBZPJkkE8anwQv6Xxn7Ze1x0UzwEB8UW0nN3VAM
 R/8CxceEoR6WvH/x5dGVylzAuiUoI/AZcG0QmuM+fR83dsVagCnMxk22O5NHbKxO8N2M6BZGC
 M7BTZi8omlVqdB8XkzFv99/C1SyyssI3ZiT3IBideBTBQcClNZkfaPOI0cI+GipC4kqNC0ibt
 Kdneyg2CUPDED8ntsdQukaboaJOyOIDznyY30LZl92CkJbCmktl9nC5nq/w5NGZ+xc9K/2TzV
 Smmx4NBqhmZ9MFyT1JVi34MGXxnKWDHhNr/TnEDRX/BplhuqnGKOvdjfVLtiAKfLGVip4o4Ug
 1r586ZYXC921SBx6a+fjfzYvc6EMgGybrCMst1E5cSUAvw4icoNVijHUo+opOIXvWznxIpyJH
 Ayd4VT25EmXUai1s/iXnc9HslD5QTemxsKMl1GtF22ZcP0l+Jlze5NRY/u6cT2N7aAMvi/ZH6
 WgTzTGYU5z3oZx/p1P/s74O1LNhqvxfjm502XhE1A==

> Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies t=
he
=E2=80=A6
  Use?                          Parentheses behind identifiers?


=E2=80=A6
> +++ b/arch/x86/events/intel/core.c
> @@ -6107,18 +6107,16 @@ static ssize_t freeze_on_smi_store(struct device=
 *cdev,
=E2=80=A6
>  	cpus_read_lock();
>  	on_each_cpu(flip_smm_bit, &val, 1);
>  	cpus_read_unlock();
> -done:
> -	mutex_unlock(&freeze_on_smi_mutex);
=E2=80=A6

How do you think about to apply another lock guard by a subsequent update =
step?
https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/cpuhplock.=
h#L47

Regards,
Markus
