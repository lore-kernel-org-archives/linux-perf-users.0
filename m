Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC11FCC56
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755329; cv=none; b=ghMjxn5Ker73EGV08fKV+FvQZGKS8nhYoc79E2HX1/8wmz1DAdmH1dmDfLyAALzIUSG2wFAAlqAN5zm6T+KnRHWID8mOsg5KO5oBmfXEdI+OigNmpL/Kqgj+u01rKTvRsm4RggnGmnVuLf9zXOcIjGbqT/D4/j/ob4AltH/14Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755329; c=relaxed/simple;
	bh=I55DVc3umMZtwJE/B7Oa+c/JP4VFip3QnIER8iIzNDM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=XmwCzp+O3c2KRj4W45VaaYAI4xpR6vU/ssl+jtJ2tE/M+Q9ppHu0UJlOIdXEYcHGFOr+u0ksv6xY+n+A0fT3i4fbOsh86fRjhERHLidKoPKECzuRdLpMI3p2+w8gBfBoiMbOYXLfCrFe37lUdbZLkiyHNYXPYDhc//JvJhQ2bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZyqavIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZyqavIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730755326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dkzVn2g6Rhti6dXYRVWNocj9m+J8sSPlJVpexm6wlgY=;
	b=SZyqavIS2raed30XjnGl54haKc53Zh2TaDjKpFr2P+4rnhiriUbmXyJWHuYhPVaaCMOIo3
	mRo4ADWHSxo/j7GaBwxbnFTUX3di1YhfgwxRQmkrlR3wfmghcIzvYmf6389absFqCjcrXS
	VzG5/Y2qbiXzfTLAChU+qGzMxcJ6bmw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-ZdtHcMSHPCmURUHU2Lka9w-1; Mon,
 04 Nov 2024 16:22:04 -0500
X-MC-Unique: ZdtHcMSHPCmURUHU2Lka9w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E084C1955EA7;
	Mon,  4 Nov 2024 21:22:03 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5EFF19560A3;
	Mon,  4 Nov 2024 21:22:01 +0000 (UTC)
Date: Mon, 4 Nov 2024 22:21:57 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org
cc: acme@redhat.com, vmolnaro@redhat.com, jplesnik@redhat.com
Subject: python3-perf pulling dependencies after build refactoring
Message-ID: <fafa202f-59a-4838-1e30-74b4862aed5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Ian,

Jitka Plesnikova has spotted an interesting fact about he python bindings --
perf.cpython-*-x86_64-linux-gnu.so library -- the number of shared objects it
links against has significantly grown between v6.10 and v6.11:

Before:

    # ldd python/perf.cpython-39-x86_64-linux-gnu.so
    linux-vdso.so.1 (0x00007ffefd1cb000)
    libm.so.6 => /lib64/libm.so.6 (0x00007f4c9315e000)
    libz.so.1 => /lib64/libz.so.1 (0x00007f4c93144000)
    libelf.so.1 => /lib64/libelf.so.1 (0x00007f4c929e4000)
    libslang.so.2 => /lib64/libslang.so.2 (0x00007f4c92600000)
    libc.so.6 => /lib64/libc.so.6 (0x00007f4c92200000)
    libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f4c93136000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f4c93247000)
    libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f4c9290d000)

After:

    # ldd python/perf.cpython-39-x86_64-linux-gnu.so
    linux-vdso.so.1 (0x00007ffd889f3000)
    libm.so.6 => /lib64/libm.so.6 (0x00007f75cd125000)
    libz.so.1 => /lib64/libz.so.1 (0x00007f75cdbc0000)
    libelf.so.1 => /lib64/libelf.so.1 (0x00007f75cdba4000)
    libdw.so.1 => /lib64/libdw.so.1 (0x00007f75cd089000)
    libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f75ccc00000)
    libslang.so.2 => /lib64/libslang.so.2 (0x00007f75cc800000)
    libperl.so.5.32 => /lib64/libperl.so.5.32 (0x00007f75cc400000)
    libc.so.6 => /lib64/libc.so.6 (0x00007f75cc000000)
    libpython3.9.so.1.0 => /lib64/libpython3.9.so.1.0 (0x00007f75cbc00000)
    libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f75cb800000)
    liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f75cdb76000)
    libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f75ccb29000)
    libcap.so.2 => /lib64/libcap.so.2 (0x00007f75cdb6a000)
    libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f75cdb5c000)
    libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1 (0x00007f75cd03f000)
    libpfm.so.4 => /lib64/libpfm.so.4 (0x00007f75cb400000)
    libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f75ccb08000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f75cdbe8000)
    libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f75cdb49000)
    libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f75cc7c6000)
    libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f75ccaed000)
    libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f75ccadd000)
    libpopt.so.0 => /lib64/libpopt.so.0 (0x00007f75cc7b7000)
    libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f75cdb3d000)
    libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0 (0x00007f75cd039000)
    libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f75cc2c5000)
    libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f75cc24d000)

I have narrowed it down to e467705a9fb3 ("perf util: Make util its own library").
It has also grown in size, probably because of this linking change. I think we
need to get rid of this probably unwanted side-effect of the build optimization.
What do you think?

Regards,
Michael

