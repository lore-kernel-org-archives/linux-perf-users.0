Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930A1F5E7
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="FtnZOmMK";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="SAay3Q/x"
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 08:37:50 PDT
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1DC1
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 08:37:50 -0700 (PDT)
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id 95B303AB007
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org 95B303AB007
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1698420479; cv=none; b=emx3YsiGMjOKNZoQYEbhIHjepE+sIDL3zcrz8qkqNBoVcpyqIcfP+jOUUufYsbj1dk5FGRCwrY5PmtVbpHqGQa6wGoPmAXBlFM3QOpbWeS3CA8WEPTcKRRm962YXoZSFqECF4+9Qm0WHQYJ9rhQINopn9fGDjxSs45IufOQ6qNw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1698420479;
	c=relaxed/relaxed; bh=HnchWwpgUc9RjLLva1UJlgTnQ9tvFoCSXyXGhcMHhaE=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:To:
	 From:Subject; b=h69XxW/GTE35jJHscY5m/qzjOrUCzLc99CEDjQEXFbcWILbq8f8DJvC4JvVZs82Nl9ea05hlmKdUoHEOmXUd2+nsiBG5g2bSkeAxbo6dfxiP/rkZZh2gdFBYcbLoV0V+AbsNjAEPBsoww61DxrJMBZWdSD/CuzylmgAIazKrpgY=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org 95B303AB007
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1698420479; bh=TEPKOzt87Vf4/SxeGWp4YEUP25rvaWwhboXHRBJw1kg=;
	h=Date:To:From:Subject;
	b=FtnZOmMK+n1U9aGpyw2Ge9OBlkTzncDinMLIB1BS99CYguPJej+J8OMJ/DyzMAHjv
	 fZ/OZYLDU+xDRcCGSzeR4AnTlHfQFBJ8aQi9M1bGkdBqpvGb/5dGT6wa6uSYSRLnKC
	 0wO2L460UYWAf2S9HrW1C+xYeXh7KdLAMhV37zHs=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id 9268B10EB7BC
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:27:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id 71DCD10ECCE1
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:27:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org 71DCD10ECCE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1698420479;
	bh=HnchWwpgUc9RjLLva1UJlgTnQ9tvFoCSXyXGhcMHhaE=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=SAay3Q/xosiaP6aUT+XJcc6qW/s1gjjGubbmANx0oEkT4ovoxZupgFhOL4UMEYhEo
	 JBeGkG3WEVcMpFpWQu9NwU8t3gRIoFesfSwEyJABHGMT0UFEIecibnUgskq9pvtAbQ
	 +saUKs+YGEUoBsmbVPSgJ2CXGLTsnwSXfWxsLda4=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id U4S22UOfHAqQ for <linux-perf-users@vger.kernel.org>;
 Fri, 27 Oct 2023 15:27:59 +0000 (UTC)
Received: from [192.168.0.157] (ip-86-49-236-9.bb.vodafone.cz [86.49.236.9])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 133E310EB7BC
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:27:58 +0000 (UTC)
Message-ID: <95afba45-7152-42d2-b1a2-2fe72900bd6c@isc.org>
Date: Fri, 27 Oct 2023 17:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Content-Language: en-US
Subject: [bug] nsinfo__mountns_enter failure can cause perf to operate on
 wrong file
Autocrypt: addr=pspacek@isc.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

I've noticed that sometimes "perf record" confuses paths between two=20
different namespaces and inadvertently operates on a wrong file (on the=20
same path - but wrong mount namespace).

Version: 6.5, commit 750b95887e567848ac2c851dae47922cac6db946 from=20
Linus's tree

Reproducer using Podman container:
All commands executed as non-privileged user, except the sysctl tweak.

$ sudo sysctl -w 'kernel.perf_event_paranoid =3D -1'

# binary in the container needs to have the same path as on host
# but different content
$ podman run -ti docker.io/library/ubuntu:23.10 /usr/bin/yes > /dev/null

# leave this running and get PID of the process inside the container
$ docker inspect $(docker ps --latest -q) | jq '.[0].State.Pid'

# ! record as an unprivileged user !
# record and use debuginfod from official Ubuntu servers
$ perf record --debuginfod=3D'https://debuginfod.ubuntu.com/' --all-user=20
-F 99 --pid 637217

# check if we got symbols ... we should have because debuginfod has been=20
configured
$ perf script  # notice "unknown" all over the place

# check build-ids in the recording
$ perf buildid-list
f53cbc885777b8cfc9e54a8015318a71e6845bc3 /usr/bin/yes

# check build-id in the container
$ docker exec -ti $(docker ps --latest -q) bash -c 'apt update; apt=20
install -yyy file; file `which yes`'
... BuildID[sha1]=3D7c895824831420bd30a372431d2b241bb6ff5554 ...


Values in perf output and in the containerized binary do not match. Huh?=20
Where the "perf" value came from, anyway?

Turns out the buildid-list shows value from the _host_:
$ file /usr/bin/yes
... BuildID[sha1]=3Df53cbc885777b8cfc9e54a8015318a71e6845bc3 ...


My guess is that this can happen when the user executing "perf record"=20
does not have privileges to nsenter() the target namespace, but this=20
failure is not checked.

I could not follow "perf record" code, but "perf buildid-cache --add"=20
calls nsinfo__mountns_enter() which has void return type, and hilarity=20
ensues if that call fails.

I'm happy to assist with debugging and testing.

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium
