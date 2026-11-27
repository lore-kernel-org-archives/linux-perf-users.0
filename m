Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797103;
	b=4OAsArV2xW9RSqaT+OSS2R/dAf0q5TUSc6eeuY2GKoshyM1twfkkHusYZV5PkjxMkMAz
	 7ge1t/gN++jh0xtvt8hNenRMo686ezflWxXF/4qOlHLcq7iHrW8EcpyoQIx7ptZgmm52V
	 whSBNf3uax7g+DhHCNoBRIukNXfsMlt7N60kDgjOq52SWXuK8m5uQwM9nIYJYLKwHKkU1
	 PnkLTmaC6vJASAQPxszwgNAgJOUVS0PQKwvEP4/SfCzrNBpFXAwTO9pnKGNT/gLwHUcUC
	 9nm6rTAtcM8QuRQ0u5feg+x24yluaflg61IeYG63kVtqZKoj4GaPtzZwLVDnk8j+u7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
	b=w9yI625GOqG4F7TqtyuF44GZSgg5z0PGBlesOKKvcB6/WNJzRRshVZHHagCz8tfogL6q
	 K9YTWnWMMp9VSQ7DaVM2NwBynnzRijFnpaJg3itw1qAcGa9THeUfhD2wh9X8CAE30m6zK
	 TpNhOJ1QDK83NhOsL+aHPPCL1DnSf9m3rLxrrfzwk2fxGotgjfIBlCdy0aObSMLFprjOc
	 yMoNVyXapksKIZ5I9X3w04hBl6DrL6omBaavcfNpDQ8sv5KzC5qUqnfjwUF+MkEC5l0yw
	 xqcWrU/FRJLSbseKjVteqveOmTob7p8DJyjuPgkMVp67q37h49KxIKHgIEKFlitjutA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p41YKBnh;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3D606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 16:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F3D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p41YKBnh
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9908c849564so2314823241.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795797101; x=1796401901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
        b=p41YKBnhuyOT+TpvRIHrMxScjBU7bBWKCDfLL0udUkj50hiYT7nd821dY/PTgq6Zqz
         YEgrBb02dHDhK3M8p7WSqluOSGQ94A/hj6um6azi8xgzJmejaGASDlqysDAmUnqIuw8E
         YTAr+gTmSk+g+TKbhv8+qD/tqAklezgjEbwQHVkwe0iQ8/m3qBaQavkXPZBH+NDykzyr
         GsZWI7geCD3MmYYglHrpPSrKlWnZ/y7Gdf8QGZjM9mNuiBR4OvIUI02U+wEDWW2wFJXu
         2GR74dMshWTG+CAgfL+L5QXyjaB2nVMXUIj1nl7jfccm7WQqAdj0hXei0CLhKI1gzf6p
         f/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797101; x=1796401901;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
        b=pW+EKTCvit9WwYmhfJCcPBVIInjNVtjSWUK70BdD/EhlEjgNe9D+qBra29v5Mpmtlc
         ayvRMBKn6VcIzfL2Ivm5QaGGcJG5NZQjghfvZMg0EEcvJgo2IsGieO+rRc4ThT2sSndK
         PYhUtylYj80aTS1/cAIH3fq+qoI+ct2Zbafs+95iLsLw7x/HsgEPYyOZ7hj9BqtkNBnG
         oXRnPPOjXDnxjBUAo0f4dx2TziToZ9F4g2VfbK2lI4Zvb5yuFr2CJYSOsTU/x0QPEDUI
         6+VGUEDAzRf5amkEdMKahwQvSgwVAS6f+37iCSK9vZTAuGhBVA/Pb2IoRy8ayECx0hQp
         V1Wg==
X-Gm-Message-State: APuU4Z9HPaJtccXiAw2UKlLoSYT2f2reJKK/gBG8gjQEaH1XEfz81mxC
	FDKnE/yGlXceJamuZK2bNL16sSkXAvV7kXzqph51xK/CK9henA+SDoD132vky8XC
X-Gm-Gg: AZFdTZebFETiQ7BttRkNeO22f/B67v7RTMyIdgGCRKeHUqCbWWsyMpqL7JiOEiC8Day
	G+p2R1r5G/toJwyZKF1V90k4xbVDMiflZOqBixtpjU7zovSzzrtQE8BhsyvviAwxgTfj5EtLndx
	KZ1QduI4piv1j9Kf5BQXxpOLNx659gB64QfQW88sjZEyPyH06kh4p3n6gNJf3YR0eZBOBa0y93X
	xCA6hOHUU5h6L6MfM+jct9YbnabGuMBn3L8CT33dfmOaHXrWlcZJf/G+EQTmJJyU92YCdd47vAD
	8EsWJseayAIB5TTr24YMUedeoofOWSIWAq1ufL7viWaJRIiaTJc8OZOUEXjZ1NC+LkDScH4guXx
	xxCS+yAWAxxjRQNTJSiX2nKqI0FwLX6oepNFAnsxsJDx6pw57B46f2i0fRSzXMIBNFfaFEBYfvD
	vsSHD/ao5kNCZPwo/FUOw+b9mnU0JpMCxYaYxa9k6WP01ry+thLOmC1G74vYbqjrBEqMwDfjJE/
	xo8s41OIEd810sfaa7T55IE+igFm1XHbs6QNDI9lGGEu4t1OmYVSxB7y0JBY1EYNO/QN206hFOu
	3zzauGaUBSYNeDkohyeNV3JV16mrvKxh3uFQNa2YxwwgfNM=
X-Received: by 2002:a05:6122:3b8c:b0:5ea:f220:fd6e with SMTP id 71dfb90a1353d-5ee8aeefceamr14730581e0c.11.1795797101340;
        Fri, 27 Nov 2026 08:31:41 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:388:90c1:771c:18eb:ef7b:e7f8:aab3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99eab8e7b9esm10043528241.3.2026.11.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:31:40 -0800 (PST)
Date: Fri, 27 Nov 2026 13:31:35 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: linux-perf-users@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Sizhe Liu <liusizhe5@huawei.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, bhelgaas@google.com,
 yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
 will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, wangyushan12@huawei.com, wuzongyu1@huawei.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@hisilicon.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/8=5D_Enhance_TLP_packet_deco?=
 =?US-ASCII?Q?der_with_field-level_parsing_and_versioning?=
User-Agent: Thunderbird for Android
In-Reply-To: <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com> <aqB37YCMUYKodo3N@x2> <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
Message-ID: <D6C7F85D-0A2C-4569-98FD-ADB616FA106E@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 27, 2026 12:12:14 PM GMT-03:00, Suzuki K Poulose <suzuki=2Epou=
lose@arm=2Ecom> wrote:
>Hi Arnaldo,
>
>On 08/09/2026 22:02, Arnaldo Carvalho de Melo wrote:
>> On Tue, Sep 08, 2026 at 10:05:01PM +0800, Sizhe Liu wrote:
>>> The original hisi-ptt-decoder only prints raw hex values with generic =
field
>>> names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
>>> DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format=
=2E
>>>=20
>>> This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
>>> decoder in perf tool to provide detailed field-level parsing of TLP he=
aders
>>> based on message type, and adds a versioning mechanism for backward
>>> compatibility both in hisi_ptt driver and perf tool=2E
>>=20
>> Series is sashiko clean by now, has a Reviewed-by, but it touches both
>> kernel and tools, I wouldn't have a problem if it was processed by
>> whoever maintains the kernel part=2E
>>=20
>> - Arnaldo
>
>Please could you add your Ack on the series, so that I can pick it via
>Coresight tree=2E

Acked-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>

But you could have taken my "I don't have a problem if this gets processed=
" by somebody else as an Acked-by me, documentation says so=2E

- Arnaldo 
