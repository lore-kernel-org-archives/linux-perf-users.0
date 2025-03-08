Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2518DB2D;
	Sat,  8 Mar 2025 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420634; cv=none; b=df03Fge7kP87VFyxe7eTq1asmmNr8I3ysQKsM0f9pfXFZjEWfARGGba1I5zh0Cwjwsi/9d4sBeHcEdd0zn2T/BxxuUoShQqBtIrEJw/0f9MaC4QRJrU7L4PW1fJWpj/TJ4Xkt++LfHtOy4VEpSD6Ox5kG5D1uBLvxbl8FJxOf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420634; c=relaxed/simple;
	bh=Zj3zJcA4uSUYzD3DvV0Arf1ZE/tEBc/rPcPhCxar2JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pu3aBLUUDuaAImjZ8ZY2b/pg9JesCVQsBW1Tq8gpern4+Q8Jm3yrb5eYpWN9PDz1HvxUW/AO/sGCQE9VTG5TfCBf+VF0AxDXogthlEh3tNtFI8kOrsXhS/lga5Q98jDeDyho0Cuu40zfbhLoPlYNpBI6x7zHggQ/DSwDwkhUmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FPXocMsQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FPXocMsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741420615; x=1742025415; i=markus.elfring@web.de;
	bh=Zj3zJcA4uSUYzD3DvV0Arf1ZE/tEBc/rPcPhCxar2JE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FPXocMsQP7BEgGbkQdM9lpBa+Ev1vYv3y2FJ+fcfLNUQEkCiDYDhJwNDD32+rdL0
	 tX0ch8kdv0P+uZ47cZAEFbqOKCNl5YEJzDjLwzq/UVpIw2mZ0pWhLIJZGICr98Bi3
	 BT6CKAwzvbXNM1PCjJUoZFR64ltvbZ6p8LDzpJzaFtO5BbuCECKjmbKAmTmrmWXp8
	 nOdEzWvWnY2D5srKa0Bmp/lrBBx+iDsxGmQvJsVsVfCXztZ41C8xesBjaatkexreF
	 aYZlQkaYKiFk+YOwyU2rCfiIu5LMpDmdwQiVebwXnuVP5hGW5hXKjrCa2oi49hAnU
	 rY0SuDm9z2A4ba6KMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.79]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMv4-1u08zR374g-00EbhJ; Sat, 08
 Mar 2025 08:56:55 +0100
Message-ID: <d2b2716d-b482-467e-9653-9219de40bae8@web.de>
Date: Sat, 8 Mar 2025 08:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] perf report: Use map_symbol__copy() when copying call
 chains
To: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250307061250.320849-1-namhyung@kernel.org>
 <2719d1d0-6e1c-48fd-b73e-42b78c51b201@web.de> <Z8tudline_-qNJog@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z8tudline_-qNJog@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mIU5Uztp5BCv3mSjwgOuclJYhvAlUx4lh0MYp2697qqnxf7D7uJ
 R4JfvKnmGbvH8/CEru2gJBHs5j8A1iJWH5ZRgBMGBaPNTh6fai7sOs8elpGze0nLmoz48+V
 Fu5ofOSgQ0KQQ7hERRAOj6fyaXGvckSOdxPjro3ZzlhKDLZNAdHOl/ZvM7w8yXY9rpaceRb
 gIoKGUoHOgvb4DY5DteTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:teHOiyEJCCw=;V63J687ciM74R8eO6PJS+pCFeUQ
 LdXczH34h0eUOo5/ReZjj4mYa0AXuGAktQKQ/hmAUICqAnAJ+iFH0upmbZjtLNK4rGc0BlBRX
 950wyQDILpavC8LDLTc+XkLq9SEW/RpqhVQdXx3xeJ5KUQ+wDq/fWKJIKuudV2kv1GlWjRqQ4
 swPneHAbPHN3GZfWq5bLwUedqg8G5oioVrS/VgBJvLwpCSzEWxOLzWLQT5Z7T+fTeXQzGboc5
 Uh6MnhWeq+qIJ2DTjeJpnMdZTkrBeeU7qsGWwb2BBiUgH1LaWGwp/Ec3dK5ucxbzUA8HxDS4Y
 jBap9p+BniYD79F4PrkqtkxHOGWk4I0HV2BEEJ4DB1Q0rhFjHPzClUuamNZLp4ML0DModN1/J
 0VKJHBRCMVztKt/24r/Rj/vrT/xyKgeveZTN2kPegFr+51lCT0KiZjL6awCWo0PdiFAd4d1n5
 V+dQ64wGGpc0RF2F1zlnKBiY31IggSzHn3M8pthjIbYLeR4oG/9QeIbd4mlgJZHzRRTCL/yoC
 piHdb/wBjxu6f9Y5QPpJH6y741LQHqu/cyNB02CbNXyxJKjULXt+BDKMGH07AEa4T9IWhh46k
 n9JHbvNrSWD+uvGnUbXM2YV1ThLKZ4IMZyZ7KLnFCnZ3XK7xzMSNoYZ1YzoSGXm18dLOrTbrh
 itELX20rcnzTXEf03jt15ig6S/NH+TGsN9mKyhSjlitoKkfg1uhq64wWqZXTX3puethKsd9DR
 hbO9SzJuVlLVWHOvK6mSw6IaSMsjdwU7IUxTk53VaJf5Fim8oSkmtGbAMZo5KLVrnvMiL8yy5
 akXf8S/eD3UjupFhXCcGZdgXxfYzSK3bWk9hofvm6Yx2tswmlpMV2W5JMny/5gHa2dolqpt9w
 wtOUyZxsv9GcDggsg8uuBx6dXmDbsWLkkK1ysqFXA/eQIlsN/TgzYNuG0BI0coYm7oPLLA7O0
 omrf/oJFf5fc/Tu28Pp/cZDy/QnH2KdjO1yuXV4f228jkVGYOAK5inMWvREIE/jlqy7ljIOyq
 m1DaEM/FNwMfHluAoYqoBKbKtElCSDb4yFNtaFFq7g2bHdBlWJZaGA8AIrCl+WwAezHnjOcuh
 WP8vsAXLjx4iE2Hj9Cqw1vSBrqIhZOUc0ufEJFMFJfBKTlT5g3yFoLtHK+rFrbMbHAk9N8h2e
 I+oWEnpZSeM3i8tk14G21/cLd5be5FMYuK8GCyEyeGeOk7/yIPzancrOQC60TP2oGHMG4zHEB
 ZL+zaGqWjv0wPr4jnmbdtnDGonxlNpjvqHIwtK+Ve4kkJMuyM6sf+ODI8tHwhkobdScp7WbG6
 bwq07ZQ1MoudwGbedtEkMPgFM7aD4ezo5fHk74jGRY1H4jqJUvjS1mZG1xyX3Ito+eKKerqHL
 JGGALJmkCc6mPjXLhVuLFslxuChAtA1l+bOE/zMeEK1AtNX5IiJxngCwLOQb6I+ezZOUP+clJ
 nYjABQg==

> It's just two patches and they are independent.

How do you think about to offer the desired changes as single items then
(without the context of a patch series in this case)?

Regards,
Markus
