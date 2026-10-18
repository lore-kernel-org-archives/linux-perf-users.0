Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFD2AD32
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306886; cv=none; b=nj49ayzYDUmQ+A/rdHDED+uftiitef/3X9Kt7A58OG3jVtSMrIX5Yg0qZ8UcyL3EeCr8atlOYh6N0Hyd+L2Zr26twJR37UZX7msn4fZYMTQuY3Y1WnJo2xxKWeir43YBXl/wHyQtyALqIZqDVTNawGP+OJUHyvAiE5HRkGC26xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306886; c=relaxed/simple;
	bh=BqHcQwnGCd6OzwvIugj0w/L1Y6XhodHIvWw2WluZ9Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MbuiASRUDPgjLpxZ2QPmBp3eJo+TiwhLaG/XK9Z5V3k4UjY66KE7KADglOKEoVqUzLTpHkO850OTuS/0nHRWcpnWYNpA3gP6TDxX50fulTx9c/ZnomNkveTdHO9nfXgaomLEiUCqN0z9XQq32JxA737PsyUK0X1XMvrHSOAfQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEB+BSJ8; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEB+BSJ8"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798eb0d13fso821400d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792306883; x=1792911683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSYd1WEoacy/l7Nz78bPf4XCY2taJPgbt8AAsSBtAzQ=;
        b=jEB+BSJ8GcNvPqYj2QAnXrBjQ8xX3NpBvuSyqtORnj8whIQuCC/EaqqFUrct4MDMtq
         xKPaKvd7CoNaJMmXAGCxY6PntD4GXaTP8CwkO1CDZJDkWqSjO2plXKqdFU5yo09Eni7V
         cAoWAu9B9xnGctNbTmt0N7a7iyDFXBuORJfQURk6sVBu9w7Q9YtJoG5JjsmYYElgkBJl
         6uzb42KwAsaP3mILQ5yhQhLe/ii0Z602AXD16ftBuWfV+SBIBJxRsIq2dgdlUE7WQGbt
         3b2WfsoZtracpohrhTIfbZ5fmAIyiVC8S+IUllkRzRM3H3jcS1Ar/n3hKecn0583m1GQ
         n+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792306883; x=1792911683;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSYd1WEoacy/l7Nz78bPf4XCY2taJPgbt8AAsSBtAzQ=;
        b=gxJA0XuWFyLh5hHST4St6xaHt/T1GNRVzhJXeEtzAagqbZIAiKXmB9SMseSg1FaRCh
         ot4/621pbe4iuaLA0RXhMxWZZ3x5XM2iB0pKB9YN+2cm0NkOhqUHzBH0FfYyqD0pZvD3
         EtgE6xR+GV4CGayNufUI/Oizy88pa1+LrZ5YuV3jbK2HL3oGdCt/e5iA3879v1D5BOCO
         Etr7d/yTCcPyKll5UBdKpG/OmKFHUQz2USiuC2HxL9pvlW2Cz5DmBOtYt4STUx+t2NY4
         am4TYu6G0lbnZY5gsM7Li3283/Zw9qmIOeBeXhpN5/CW9aR6xA/5AVRgU03aKMHaONlJ
         SVmA==
X-Forwarded-Encrypted: i=1; AKwUvBwsXTbKHtVc7uylBfGQo+6XpNUXOZ0ANd03uUIKYvL+fvjfISw3G2qtF4VveemEu2BiVcFsXzYEeem0+K1eYlLB@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ87CRPXNHefYf+hghD5esYUNwbp2FjtoQtQbSkrToV05u1hfJ
	bMrPy2l2YB4Z5d4MIantHZyFqSHUT1ueImbVddwjwfOcAlY3BEzRJb0r
X-Gm-Gg: AYBFou39ZGtF+6bWqdVa9vReGglt+moV+gH/u8fINUA403EW/eNgUVDgtZRoR9R5wKY
	n019mpyAS3JP+553i7NkYypuSTl4361J5eZUg/l7fAyksdF45m2uTJxwR2WKM1R+M2lhk7NZBMz
	uKfZfHyxzePT/avdknXwAFi4kDjZBjXbr7QLLga9fGbuYf916rGTnjFZPr/xyjF/0HpSpvvF5oX
	j+tq72lqGP5KP9F3g5AqmdKyalyLKI4dfBSFClBM/2d9FM7sKIrMhw1x3YNOuNXURX/saSyYGTa
	0GXdApTcOnQnX+oQMts4T6OBggNGJsy7q8wU4OYvo/YOuzzJHrG1RHQ29LVHXErD8xKtV68hFNs
	zU55Z7frlLBq/2an9ZZD/H6KlQM6hqapcWW8yxk7aNLNHJoM8YiVdRA6Kp8ZhKi672I0RNTmv/W
	LVQ0xW50Amkwd3k6lW8cR5udrjs+oMTs8otd40NMX+rhbSqvV5xM9+8nRG+jyy2YgMpzw6y/4UY
	U/3FigLCHwNrmf4NVEGDhINEQ==
X-Received: by 2002:a05:690e:140f:b0:679:a353:7a83 with SMTP id 956f58d0204a3-679ca7ef9abmr1388793d50.41.1792306878810;
        Sun, 18 Oct 2026 00:01:18 -0700 (PDT)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e57295d6sm27714237b3.3.2026.10.18.00.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 00:01:18 -0700 (PDT)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: irogers@google.com,
	alice.mei.rogers@gmail.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@linaro.org,
	leo.yan@linux.dev,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: perf build: default build fails in pylint (pylint 4, missing optional modules)
Date: Sun, 18 Oct 2026 08:01:10 +0100
Message-ID: <20261018070110.927636-1-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ian, Alice,

Since 5fe83fb352c8 ("perf build: Make pylint build test opt-out
(NO_PYLINT=1)") the build runs pylint whenever it is installed, and a
default build of perf-tools-next (1c90f0a3c8a1) now fails in pylint for
me, on Fedora 44 with Python 3.14.8 and pylint 4.1.3. With make -k, four
files fail:

  pmu-events/jevents.py:1494:26: W4904: Using deprecated class FileType of module argparse (deprecated-class)
  pmu-events/jevents.py:1496:33: W4904: Using deprecated class FileType of module argparse (deprecated-class)
  tests/shell/lib/perf_json_output_lint.py:23:31: W4904: Using deprecated class FileType of module argparse (deprecated-class)
  python/treport.py:12:0: E0401: Unable to import 'rich.markup' (import-error)
  python/treport.py:625:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/ttimechart.py:33:0: E0401: Unable to import 'rich.segment' (import-error)
  python/ttimechart.py:1086:8: W0201: Attribute 'virtual_size' defined outside __init__ (attribute-defined-outside-init)
  (and a few more of the same kinds in treport.py and ttimechart.py)

There seem to be two separate things going on:

1. Python 3.14 marks argparse.FileType for deprecation (it raises a
   PendingDeprecationWarning: "Simply open files after parsing
   arguments"), which pylint 4 reports as deprecated-class. That needs
   a code change in jevents.py and perf_json_output_lint.py.

2. The rest only happens because the optional textual and rich modules
   are not installed: the imports fail, and pylint then cannot see that
   textual's App and ScrollView define sub_title and virtual_size. With
   textual and rich installed, treport.py and ttimechart.py pass, but if
   that environment lacks setuptools, util/setup.py fails instead:

     util/setup.py:15:0: E0401: Unable to import 'setuptools' (import-error)

   So whether the default build passes depends on which optional Python
   modules happen to be installed alongside pylint. Should import-error
   be disabled (or those modules be in ignored-modules) for the default
   build?

NO_PYLINT=1 works around both. For mypy 2.x, which fails on jevents.py
in a similar way, I've sent a fix separately:
"perf pmu-events: Fix jevents.py type annotations for mypy 2.x".

Thanks,
Lalit
