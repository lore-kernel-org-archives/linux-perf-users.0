Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6871642B
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243362; cv=none; b=M80yf0TTWMLNcbFopmb536wt7toPZsteLqbCqlW6e+TPu+JuSWl/ZT+F/HeEQwLSBgtJYx3qZNuBcWGrFndkF0FW0I83B1KMz4ilk+JMe+lq/yl783WARJhtZ0h/OOAIl0Y+GlTeofOwQocFbs8gP+rbZdgVtYety6oo+ylik50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243362; c=relaxed/simple;
	bh=KjxeqFpOqPzC89GWz+nJ1VQmrEmfEYGmq7pPsLrBIHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cG2Ko9S8Ec7DRpyma3DIFB+hywvq4wKy2UTU/abgQQpASazLyJ48Dj5AQOsCpumWvWRlLRUjiFNdUG1onAWaL6efTjYSOj1YYZv6bwuPc7KY2NfYNPb/txzO0GLKIbnIo7DXuoWPxe49kgJ8IPupC0JiQ9vpky1uZkCaIB6YQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net; spf=pass smtp.mailfrom=secretsauce.net; dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b=VS03fy00; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AN7yAvxd; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b="VS03fy00";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AN7yAvxd"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 0E5331C00172;
	Tue, 16 Apr 2024 00:55:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Apr 2024 00:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secretsauce.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1713243358; x=1713329758; bh=jgrz6C9254
	o4JqtvtB0/k3oHtmo1rdR/fN0yo3BSxdk=; b=VS03fy00iB6kGsMCAWCdJU+By0
	eLqe6oB66UScrw9jRSrU86X7BAVkjbgi5kD/yv15Ecdh/pYFkWeeR/s7wg7+vkgy
	nrZ/NbADS+/KXsd8Rtq+OdtAd1OuhDdjr1PoIb2E6FnXT2QaNOw+KXi/c/fxtpVh
	RAUd3aGhklFAO8F+UPoPcTAAlqNlyE+axUhwz9lDTY2XmVCnmSC0PNQLQ2NvEKzG
	SM3RKRjVjUZEPq3CxQtG6r+SFjcMy8x+P5RYfWDy8QWG6yOE9ZUm0a6mGdfzG1Ow
	HyPGDaNCc87lUKqhzp/30wMibxRofe9AqjWOUtHlEV1StotKjI2BQhBuBa2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713243358; x=1713329758; bh=jgrz6C9254o4JqtvtB0/k3oHtmo1
	rdR/fN0yo3BSxdk=; b=AN7yAvxdo5aLeMVg2euuZ0ypGvd/ZEs6mvkoatbpgUR9
	qaIm9kl9O4bx9AOV3eEA99U+1jQHKuP1Q0tcrfaxctuD0wSCJOzqhY6BuHxAS2rO
	kdE37c6K1eatmvhftVIMh2VWQZY9DuQsdCsVnb8w4pY5QXXnko487sRohtk1M/7R
	eTM0MIjm5lCCfU6BqL/pJDGjRpeJQmzbzXHiLwFoIuPeedGut6cHU3c2ekEIvHKr
	1s2gPyAzYPATYUc1loghusawliHMlMuw+IOKZvYxcKa35WApMmziXqU+LflRZp/Q
	0PNq1nk4Nyk33aYcdyqtFgdR6odWvJQKPMI7cB56qA==
X-ME-Sender: <xms:3gQeZp0oFaGzZBZTmmQjNmEMEC-ozPEMRXFLcZd1Rpk_9hDGrAlGvw>
    <xme:3gQeZgF1MXeZ40APvGBqnOcIgLy0EWFym0079HG8NC01pXwc4bZLNJLnOLiFGZXmq
    vw5fLkGytWhUIhb>
X-ME-Received: <xmr:3gQeZp4PeuEPD84YX6PeP41Ta_a-igjiDGW8BTihkhgrFjdmPaWWLYil>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeffihhmrgcumfhoghgrnhcuoeguihhmrgesshgvtghrvghtshgr
    uhgtvgdrnhgvtheqnecuggftrfgrthhtvghrnheptdehkeejffehjefhvefgtefhgeeiie
    duvdejgfekgffggeeiudejjedtleelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepughimhgrsehsvggtrhgvthhsrghutggvrdhnvght
X-ME-Proxy: <xmx:3gQeZm0GjFk2BCAZK8CrGfcq1-593ymDYXIDhd4mv9XCYJ-0SJClrw>
    <xmx:3gQeZsFuJJ2aHrltH8-JDo0Fe3JL_VFxS7eQpk2CgInBUbnB7UfXEg>
    <xmx:3gQeZn8q15x2OADNnapYDwfRBCobHkZOPO6FbCRP_0On1WxQkjnvFQ>
    <xmx:3gQeZpnDfNkK_09SRBMHRQDK1HS46KC4C1H4k_bShfQ2iJjurA32AQ>
    <xmx:3gQeZhQzLIDOQH8T-6dETJ-AoqQbFxQeIBY9qDVcGgjpqVe1l-8cqqa9>
Feedback-ID: i3e8042a0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 00:55:58 -0400 (EDT)
From: Dima Kogan <dima@secretsauce.net>
To: linux-perf-users@vger.kernel.org
Cc: Dima Kogan <dima@secretsauce.net>
Subject: [PATCH 0/2] Better error messages for 'perf probe --add'
Date: Mon, 15 Apr 2024 21:55:09 -0700
Message-ID: <20240416045533.162692-1-dima@secretsauce.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi.

I tried to add some userspace probes to some C++ code, and got this:

  $ sudo perf probe -x tst --add _ZN.....
  Error: Failed to add events.

Note the completely non-useful error message. The issue is that the C++ symbol
mangling can create very loooong symbol names, causing perf to try to use very
long probe names by default, causing this problem. It took a little while to
figure this out, and a better error message would have helped, hence these
patches.

To reproduce, here's a tst.cc:

  #include <stdio.h>

  namespace n1111111111111111111111111111111111111111111111111111111111111111 {
      namespace n2222222222222222222222222222222222222222222222222222222222222222 {

          void f(void)
          {
              printf("f()\n");
          }
      }
  }

  int main(void)
  {
      n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
      n1111111111111111111111111111111111111111111111111111111111111111::n2222222222222222222222222222222222222222222222222222222222222222::f();
      return 0;
  }

I then

  g++ -g -o tst tst.cc

and

  sudo perf probe -x ~/tmp/tst --add _ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv

After the patch a better error message results, and the workaround is clear:

  sudo perf probe -x ~/tmp/tst --add probe=_ZN65n111111111111111111111111111111111111111111111111111111111111111165n22222222222222222222222222222222222222222222222222222222222222221fEv

Dima Kogan (2):
  perf probe-event: un-hardcoded sizeof(buf)
  perf probe-event: better error message for a too-long probe name

 tools/perf/util/probe-event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.42.0

