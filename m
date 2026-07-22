Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B230C164
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758788; cv=pass; b=ThRJA/L/WrJprvm+nmyQJcyfj0t2MQrfT/eP/OuipBMpArfYqXGyRcleM5IpA+3o3mNUTsVxqBC2l6GQhozuzzD+mN6UOteYZeJpg3vZZvQkS5fsO2ttZNhk10MbjLFkgjel4Ev1bnMhhcW+xJ8DVTVjIzN8vPsVyD7aQ1jvHQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758788; c=relaxed/simple;
	bh=nvOkdvxUYQ2eWCG5t4YaWQHp4JUali09FLGYLUD5cio=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZF7r+UVB9rDHC3OPkwBETOY4S1ZP9uCqos65nfklVhIbICl3z1VP2BSQl2VStqirbTcd/WVTjP/Xc6lqsYW8Wx4OrTl3ywUQ/9PspLs8gy9HOk0fU12p0KXsVG7MclW4EpEi1UuOs3nJ11orT6W9WwZa67b/1tHnHzWfxAjOyrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLCr+luR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLCr+luR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10e86e52so18391cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 15:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784758786; cv=none;
        d=google.com; s=arc-20260327;
        b=TfokzQ8XATOGE8QGdYZaBxggQARWBvqFpJVZEAbS9MHaiEv08ZFr6ZgeeiZRtJIu7S
         9tll44fqAcNzCw55Ny30J8/u/gNFTvsV3oozugMyXqGQhg3vHDXbYhPB/rbzoIeoUDej
         rfF9jmMXmcnWzdxmSDOplQ12wE+I29ogJDX2hueD9Tcn+9KwNpL7gKPaQyy5kXzD1XbY
         yqe3pwcGbvnLAC9cInGuhtOzBDhXwQEeOYYatW9xMoj+7+Sl8om2W7vOWEwCOPBFX+9d
         HghRaVqeYfrbYcuTZE9/fztzJ908HBYm2m/oMKw/0ROkzPYtwrgLzwh03pD3nZXz6Dky
         9a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nvOkdvxUYQ2eWCG5t4YaWQHp4JUali09FLGYLUD5cio=;
        fh=t8OuTzzvqg+3wDdqGHBzFQ9IE7nhquQaa7ECUKQdzpY=;
        b=aTnUCiHJoYg1XHNS+RTQB327ocKOx+B80lZUW3lz9dFDSlIdZcaWGFSXaZKYUB3MNw
         0JMnN4lCbi+/fDOdVAtLy3u0F14lhDYepecxu3jDwf9nUbKx4g6Qme+5vM4t1Irougxd
         hHttgNp936AoxH3plax9YoMYvAKl5T3h5nk/rr0PnWPaRwPdQi0hU5zl5sOe0ad2dwGd
         ezVKhJcId0/tGvuqPsMu+tMG0jZC46k5ChMWMEFFJceHvo7LXxrMlxuGxq2+oM9wR+o3
         pADVapX76g5+cluD3a4zpiXOU080xpIKSMa1t6wPgcZyiCBgygUNw11IbJQ9T3xALiob
         hf+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758786; x=1785363586; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nvOkdvxUYQ2eWCG5t4YaWQHp4JUali09FLGYLUD5cio=;
        b=oLCr+luRu02ycwQNb0BUk7kGfCQWQ5XkmmYmRNMlTh1FTvwMKtkh98JZlkS9wMZNZS
         DE+PZFd9AtNmAaVl6vs4J0MIU/JzE2r2jCUkRxtV3QSV7GnR9k1o2GBiAix3Sz9+DcAC
         J6giixprjHH5VPqxDS7kpNcHAWtnq7EdgWEnBNKsYYE4T85odnxOKkp67lKBxD92UZVy
         RGORAhYd1bHlNoG9e2EQGq5Ay9yAbtVykCuZJOqOjGTSHimQtKAFa0aMdLxUkUci9v0v
         b4L64IiIyuPAqTyv9iKeikrqmnWCwkQs3dxTvMjKhejZ5EGrZeLfQkczeHKyEQb3TIco
         629g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758786; x=1785363586;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvOkdvxUYQ2eWCG5t4YaWQHp4JUali09FLGYLUD5cio=;
        b=RY8+0MS1ip262mAjWsM5EBrY+Ju9AgGplGmwOwEi0ArQMonAlC+HzDKcsqa7NXArVS
         o/yRHEkCJJMURY6DF+bB2mF7QeOyuF0gvv33Ij1epU5bmhp/Ej+p0bsDOpK2TwGA/nqR
         dHcsJJ+uPhCvlPgizHk9JZ2kvv5OC3FxyxmyJ5J0Bo+rvy5i6DOXmHV7WUetjhCB8HAu
         2t2IjZKDqpF12X7j2tXOo7757cs15jV4ygFLtaRIwGBDDdzbETwFMycqpEsxe5CQhMSt
         n5alV5TuwVwWx92eX3NqLejo4E8QMM4LIMvHDjyEUuBLPBRqY+Zyn/BwHSm7gz351Z1M
         V04w==
X-Gm-Message-State: AOJu0YwH9o+XYB6ciBwk1+YTeWhwUc6oHHdq9s58Agymgr17AJEyRsf0
	M3ZhkQgU4wmjKMn9G//HzJHe7DJbD7Wp13aGsobeKysB7k68gQi7NIUKHfnghxiockRUtrkxk+o
	xSqnzAGCXT/tphPVtYERaQlQr/l3JEMkb31sP6IRSDuMeifPl42j8OcpYPEs=
X-Gm-Gg: AR+sD12efyC7k0RwCtbFQ5ha3ZT78cYlP+BVxsbdVyrFc8ZHo7yjlDLL49fU7eYAO28
	lLrjy3aqQTc2RQkwF7iJuLIsnuAaNGqYnqNKvE/QRxEYd2r0xyg+ohIcozHJ3quRPJ7wat4Y4Jr
	zqdd5BAiin5c6a2xfnWwfI7tJa0KjsmeztxK+OKUI5Lz+mSWFA4MEipIGX/wTyt9ZDNstREnFqD
	8+UbMgeHcG1N5WJpYz8uLxotp5Su7P9plVr6SEdFnFjwlTUorkxP8wIDMuC5i0=
X-Received: by 2002:ac8:5802:0:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-5283d8576f4mr1540071cf.15.1784758785485; Wed, 22 Jul 2026
 15:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jul 2026 15:19:33 -0700
X-Gm-Features: AUfX_myba1DSzLaCzr6uAzadebvIo-Q5WArr8gnBDXnvemETkFrVpjU2ZbaELQo
Message-ID: <CAP-5=fVpPktV2Y8XYxOMpZuY1oYQMwxmwqtaphRG4i6qkSVZyw@mail.gmail.com>
Subject: Getting positive, and not just negative, Sashiko reviews
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I wanted to give a heads up. I sent out a 1 line email policy change
for linux-perf-users to get positive Sashiko reviews, not just
negative ones:
https://github.com/sashiko-dev/sashiko/pull/363
Please comment/complain if this upsets you and I can abandon the PR.

Thanks,
Ian
