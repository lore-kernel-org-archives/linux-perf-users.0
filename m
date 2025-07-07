Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73C1EB9F2;
	Mon,  7 Jul 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891291; cv=pass; b=dvrA4WyD/xWnq+5owxz0bCNsAFnPHBmSWSi3OfzkpWzSray5z+A/xrTwut2fCHcV8tTYz078aeZz7hotSbjUWTGFJbvrah0Vh9sR0nBdKiAcjxgFqpaR6WAREkq/Bv1Wy+Irg6fRbInUvHdzKIVEZ8D+C20XmPq6aNXCCeW4ET0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891291; c=relaxed/simple;
	bh=Zj6Z/wzSlDLMrTXQ9RRjKi+ui6hO06jXMM4nuMgaUJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aA0oj7PwVx3vrGMPuhKqRyuRFASxZMld6W0Zg9X7i99fWbIcTnaIX03h8wxD4i5jIG/97gq0qps71nWlxPEVaBqcRgXs2wRcTry+q+8ZhpgU0AF9VzooJ7rrEq4jc43mE+rXhGd0ecpkgciHxnFqRKg+0twD4/QJzYutF73mQeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=snjCD2GH; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=+30guIen; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="snjCD2GH";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="+30guIen"
ARC-Seal: i=1; a=rsa-sha256; t=1751891114; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qLvL5btq76tCl93yHMh5GbtF1TU/kKDJYI1NC8HNKgBUhwqjhOdefkHtkBUr1+imej
    zG3aAVZAsZMnO6489ZRfFceRQcMl67EKgxg0yz74d9XjAinMyunrPQnsFeDSywD2Z03G
    o2I5ztgcoghn2eRpiz/5limJrKNzCtBKGDFEbMnxTzHh64od+ixnwI40aNA41o7h5+PW
    OktKHV8WN9d4u6iMvCt8Rp5PcKQokMBynklXgLHMsKHjg/L5eN6MrUyGtyc+P/RGHeDs
    tEpkxj8rhoS/F07UfRp1S1KG4X6v7+WCPrfv+6h/J1mtO9dP5kcrMsmwP76BJL+QMxMf
    lp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891114;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VPfHIHEioSO4QEZUW4uh4Z/t4LTmuxZYNv/M1hpZBqg=;
    b=AdL2K+lgEFCAZN835XrTaWukAlipFz2j/6HtiBMOMom9VALpch9ApePXiSCWm2hAJY
    +Et+zP/hFSs8eh4qKJDf7Q4ORYpPiK9GcrYQDtaLayhyk67KwnkpzMuLmDczZBf8Rh1z
    keP+DarB9ND1ILJigMW1mYX+n0MWJnLwpDVuLJ6TpXPHF4l5XDRea1YyzA47IE4YHg5H
    kbsb0Q58rTDUDTIQvEsxgwZM4YmlkQDau4Fz70TpKoYCxOy9oOv6nl/vZ9TAucrJhd1V
    do6cAXejntJhOLnLgg2IIeivQorfjXqh5ajgJ5iMKFdJ+jTs+JdxYjxUAsvNm+kwkKj4
    uYjg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751891114;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VPfHIHEioSO4QEZUW4uh4Z/t4LTmuxZYNv/M1hpZBqg=;
    b=snjCD2GHbCwJ5CYLSwDWKQ4VfmxCRN6tsXHarO3XSpKdFchXFwy4hpfryFU9SSjyoE
    R8EvGEj5Adgi+BEu1/iAe0ofbsBzuJS4z4FgBD5wDtu2mHoLbvLn9cX9zSHpfnX7cUa/
    z+NZSoKxvFNkRBgIRtIHNc9IbWBlyzKhyWDh0HkARejQGSE7mfiahfIqjIwSNRJscixy
    ryk4oUZp/yjpe/bJVf/m/jG5iwaT8KVURQYmxwpN8VjSpvO2/SoqFHKiCLp2mv2uOhWe
    7IGSQU4rzigcZVnrKdnyAXkyw3NK/PGW7lAbmo6aRAi35WU+Vw2TnpGuCptHBlDbAzP6
    cOKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751891114;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VPfHIHEioSO4QEZUW4uh4Z/t4LTmuxZYNv/M1hpZBqg=;
    b=+30guIene+CUQkO5kjur2v9iDhrkOsM1Mif20DTdBpxWmzkUpYLvijx1KFp4JBCnKq
    Uo9E9yONDvisun5ZYRBg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J1bd32167CPD710
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Jul 2025 14:25:13 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH RESEND 0/5] Remove remaining __get_unaligned_cpu32
Date: Mon,  7 Jul 2025 14:24:55 +0200
Message-Id: <20250707122500.724699-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

I have send these patches already as individual patches, but this was
wrong, and confused people because they have a dependency between them.
So, I resend them as a patchset, which removes all remaining apperances of
__get_unaligned_cpu32.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
Julian Vetter (5):
  Replace __get_unaligned_cpu32 in jhash function
  Remove unaligned/packed_struct.h header
  tools: Replace __get_unaligned_cpu32 in jhash function
  tools: Remove unaligned/packed_struct.h header
  tools: Remove the check for packed_struct.h header

 include/linux/jhash.h                         |  8 ++--
 include/linux/unaligned.h                     |  1 -
 include/linux/unaligned/packed_struct.h       | 46 ------------------
 tools/include/linux/jhash.h                   |  8 ++--
 tools/include/linux/unaligned/packed_struct.h | 47 -------------------
 tools/perf/check-headers.sh                   |  2 +-
 6 files changed, 9 insertions(+), 103 deletions(-)
 delete mode 100644 include/linux/unaligned/packed_struct.h
 delete mode 100644 tools/include/linux/unaligned/packed_struct.h

-- 
2.34.1

