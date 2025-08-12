Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B42B9A5;
	Tue, 12 Aug 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006425; cv=none; b=bwpgowAMAyirGSSASz1TTAqzNEzn0YlKNnjDNKAmheU/dd0o6wpJ18m7o3mKyeVKBc+GTGS0Q9HHD97o163OJRTAx9fJbgjIsdClaIXXDCeW9WDH3UeMNFacq7JAva9QQNyvPoTVwrmOEvAIYCnHmWsmtf8yPMGm95V4VXOshG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006425; c=relaxed/simple;
	bh=a7raolH075RwFyFJ31dERJoAbYRgf80w/JOwFYxkiog=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=D6JmWdXL/vq9Zv5Lk2d8B78Y0OPLbicu9VSedMv3iY2rSGdqhe4WBkioBG6a/PRbo+/2tdRgsmC6VoGr8YSFvQqeTvWVkn2LxhYDtFtr5FDi95He8v3ygunUTpqaXJvOa+9PGoua80x9h7Yw/AeVVPUgWg42zUm9E6s7GuEpseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=otPh6u3S; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="otPh6u3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755006384; x=1755611184; i=markus.elfring@web.de;
	bh=a7raolH075RwFyFJ31dERJoAbYRgf80w/JOwFYxkiog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=otPh6u3SNJ/hPLZkdNr449mZUbtQe0686UErBvNljnyc4dS1UunK283DdZ+7GUQx
	 M4n3FpTI63rFujD8HTQyXrN7wQjCelajKTO4Gz+v1cXKRAfzF+dEHpe8IkREclZlQ
	 rNeRH1iZoYbCY9e2VqhLrMhvT43cuOSxvQthbG/43moA/ubjKzn7/8Cljvz2Z/OCm
	 PB/Vyjy6SpaT5r+egD0iyQs/zARJ0o9Sr2zYGcJ45P0MCYEjII+h3DXXov8BuETJz
	 GVCW8k8SQFa0gwEorPbpiW1dRgNti0DKZT1EIontcxB3pWZniA67bAeVUzgiRhGiA
	 d5b/QugNJDkvI0xG9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1u8vo61M5G-00d8kd; Tue, 12
 Aug 2025 15:46:24 +0200
Message-ID: <f45b78e4-fc62-4e94-a88e-87b078ea029a@web.de>
Date: Tue, 12 Aug 2025 15:46:20 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, linux-perf-users@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250812063546.13797-1-zhaoguohan@kylinos.cn>
Subject: Re: [PATCH] perf drm_pmu: fix fd_dir leaks in
 for_each_drm_fdinfo_in_dir()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250812063546.13797-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fG0GJAWv1b01H5JMBes8kDXclvsXKcYdkt7Qt+UraVwqHUfKErU
 YD5GCJSVRi3xGWy88kdbkd7hH39R98Xp0hxLapUfGyHw4RtmEFj4f2yrtaoD/oIOKULzyIH
 YPLEGte6QcS0nJVzQDc9a6AeS1RAlO4D60drNc6gvQ4vqH3xIVpSgP+Gch/ufK3MUYT6tIZ
 gkeSeLoqRKHLRKYzjYoGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4/7kUQb3/ow=;QmCnZSQD790Ss8givLe6az8ulZI
 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

> Fix file descriptor leak when callback function returns error. =E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

Regards,
Markus
