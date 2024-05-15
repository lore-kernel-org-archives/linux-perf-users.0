Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3760158DA0;
	Wed, 15 May 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797696; cv=none; b=tHxwmbgU1m/wo6kazkgtXkbZ/YxzNiF5Toluczu+evDSy0CONeaou9E4TMdesqfM+Ldf73DNWgAZFSIEF8h2wh+j98rUHtOtuYa1p0uB9sS6CknfA/CKNinM5wsQnB6+S18i+BFIFghGDpuzSOD6QgMnggYZvXlU9/Y1HXTZ0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797696; c=relaxed/simple;
	bh=hUZhXekL3czb/m0SA5YEhBv9lBYNkRRC/zAjd6jzNaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=secOBWlC33L7vyDbCTwFkbW1X7T0C2amkktcfES76LgY71eThccKpqI+fnqS1N0XnVm0HNo3Mxfmc7Jx9yeK2HQfEKuAt5MXT/T7fXMN6camjLRjYVn5n66hwAXXw0QlNZQoxlySAxCJFZr6y6ei3gWj2WiNc27+818guzCOhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h8e6oT9x; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8e6oT9x"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FHwoPv019778;
	Wed, 15 May 2024 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=egK10wqwXb2fu+g1i/MZi3vjpY9NQX6hwN6M7fWN5jE=;
 b=h8e6oT9xQPO9aaX3ZcuvgmjQ1N33VfQcsJDGvmcBYAN1qdbOvwcSEkx4aFNzIdOQqaXA
 c21+EWhaA431tNa0Izbpkxk+0C69Cf0YJTJLFAuq30OhAZiNc+t31mRYajuKw0Ry88gV
 9YvQ1PNR1sGzHMle3HvHPhqB5hc8T8O+ry9HoVL8zkubD3TJ3uZ7rj69r0/rNhYQsYb+
 RSY2RE+LhHP8aNAGGVXnwQrWbbvVxIJQOrqv35VEiE2aciFfDaMm4D5Xp4MBOLquXWlH
 xw46Jy4W0mPvoyJsYpNtwaLxZhcr4bxcKWP89KiyoZ7+chKxv7iaIr2XF7rt0UwR0MqX Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4fdrd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 18:27:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FILG1Y000426;
	Wed, 15 May 2024 18:27:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fssgrbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 18:27:52 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FIRpxg001892;
	Wed, 15 May 2024 18:27:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fssgrb6-1;
	Wed, 15 May 2024 18:27:51 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH RESEND] perf test pmu: Fix file Leak in test_format_dir_get
Date: Wed, 15 May 2024 11:27:50 -0700
Message-ID: <20240515182750.489472-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_11,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150131
X-Proofpoint-ORIG-GUID: AcnBaErCSbn2XednvMCck8PnKx0IUKBP
X-Proofpoint-GUID: AcnBaErCSbn2XednvMCck8PnKx0IUKBP

File is opened inside the for loop. But if the 'if' condition is
successful then 'break' statement will be reached, exiting the
'for' loop prior to reaching 'fclose'.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Found this error through static analysis. This has only been compile
tested.
---
 tools/perf/tests/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 8f18127d876a..f751e6cb6ac0 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -106,8 +106,10 @@ static char *test_format_dir_get(char *dir, size_t sz)
 		if (!file)
 			return NULL;
 
-		if (1 != fwrite(format->value, strlen(format->value), 1, file))
+		if (1 != fwrite(format->value, strlen(format->value), 1, file)) {
+			fclose(file);
 			break;
+		}
 
 		fclose(file);
 	}
-- 
2.43.0

