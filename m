Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBC6F2F2;
	Fri, 16 Jan 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584630; cv=none; b=O43L4VCDWQVN8YloSwXpdQ8tdC6fXW+kjMZIFd5RBSW7WVjMvs3KMmROAWe2dZ4mVLjceMR/VrBAjs+oj5ZCVEj+ONwLRGCCGJmuF9CDciGzTpL/3qBpObUVlRJdsyjsDuVTG66qCUWKPloZMOGlKp9zYyCBfgQrC8MgXvFLC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584630; c=relaxed/simple;
	bh=kJpxkD9vphEDQ0O3sHFX80YVU/qa5cWMhy/NgiBMohY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReLNXd3EL1nYXZHu0yUGQ1X3rG1SmAw2969GSP6YvspsD63m5ENWQlKXfKHu1LF6IbZ3Re3S+hZ9+WTFczLYKlKF7AotgvR04zSFdhNHDExaTLbO5VJYKiHKDjcAB5NxfOAEPG6XzQHSdXsYnstGRQYkZjKd/sypCnY+IuuIrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IYes/QAq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IYes/QAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768584621; x=1769189421; i=markus.elfring@web.de;
	bh=JqBrhbKMlj7HpPqfR/Hke9S6b2TdYZ7tJCKR4enFbV0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IYes/QAqXeMQgl3IVWgmXRkrWouvelfoaXYU9RwXlSnN0h8Aa4uH2xOw+qX3E49A
	 1fMZVsfIbabfVRzhRrO5ZpqD7Q5a1RI1gBMkR8eQTw0cHjJiyzOwZpwHU7M0ErAde
	 CdOBCj48GEV1kuArYXNwYZkhC57aUfYrfuR9nQtcIxvIj2UywUUP7vdLhr+O5jpz3
	 SiBNhmHhR5Y53qYgKRvlnql1vf1f/mqnYcRPdxoMEXNiKfI/xPNGkTnas4gwyqqkd
	 lsIcM1rhiEBSrnj6kgQNSyO79JxWTAlya0DCeqZS32KbGuIbOGR7A+VHzgoEHVbSe
	 P1uFDUzuLCA7ct/VLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVad4-1vHOUz2Vzo-00PFvU; Fri, 16
 Jan 2026 18:30:21 +0100
Message-ID: <00565b33-c47d-4529-9590-56f93ab45d10@web.de>
Date: Fri, 16 Jan 2026 18:30:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Chen Zide <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
 <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
 <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
 <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
 <afc060ac-0cb9-4e2f-8cdc-029ac7679246@web.de>
 <092c955c-4f27-44ed-9e88-dc721e1d2959@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <092c955c-4f27-44ed-9e88-dc721e1d2959@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u/xV81UCLPujAVvGeA+fPIC95eCDUv63urZ3mKombUCuB5p89va
 +GVgIhbFwW4WY72aOs47pocGOltSdZ54VCDuf0j2MB0Dt/iBQAwKR2sSNzYKltpdnKPKgg+
 T4yPlRjTXLfumWGSys8/EijGayJzBetLWrDcfwB6mnJqfP7WQD5v51OvmtW1aWgWlce4ukx
 gLRlXhgQ/lYdc3rDgGW5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tUnjyiyJelg=;iA7JzJ3XKHGQwXrxPAaGdFviPkg
 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

=E2=80=A6
>> 3. Which text part of your change description does contain =E2=80=9Cord=
ers to
>>    the codebase to change its behaviour=E2=80=9D?
>=20
> OK, I see your point. Yes, it's good to add one sentence to describe
> what the patches does.

I became curious somehow if further contributors would be willing to care
a bit more also for this wording requirement.


>                        But I guess this patch is simple enough.

But it seems that several technical details triggered special communicatio=
n challenges.


> I don=E2=80=99t think this change alone justifies a separate patch, as i=
t would
> add review overhead without providing much practical benefit.

Will any other contributors dare to add related insights?


>> The corresponding change recombination can occasionally become more int=
eresting
>> for selected development ideas.
>=20
>=20
> Are you suggesting putting this into a separate patch?

Yes.

I propose a stricter distinction between a =E2=80=9Cquick=E2=80=9D fix and=
 subsequent refinements
at the discussed source code places.


> My impression is that the change is simple and closely related, though I
> may be missing something. I understand others may see it differently.

It seems that we are struggling according to recurring factors of change r=
esistance.


> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>=20
>         /* Read Global Discovery State */
>         memcpy_fromio(&global, io_addr, sizeof(struct
> uncore_global_discovery));
> +       iounmap(io_addr);
> +
>         if (uncore_discovery_invalid_unit(global)) {
>                 pr_info("Invalid Global Discovery State: 0x%llx 0x%llx
> 0x%llx\n",
>                         global.table1, global.ctl, global.table3);
> -               iounmap(io_addr);
>                 return -EINVAL;
>         }
> -       iounmap(io_addr);


Regards,
Markus
