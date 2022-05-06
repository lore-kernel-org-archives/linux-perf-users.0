Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E266C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 May 2022 09:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiEFJh4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 May 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiEFJhy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 May 2022 05:37:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F2106
        for <linux-perf-users@vger.kernel.org>; Fri,  6 May 2022 02:34:11 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2469Bai1003396;
        Fri, 6 May 2022 09:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=Tpu9k8bLiwJl4l4XcYf8oGOXBeUxpcUtS/nXDQeOPHU=;
 b=YsTjauekZXH7tMpBgAfvd+ABWqLlwKmubfjkyWcRHFzJU8+SIPBqW0J01afrzkTtwtEu
 R2arbWJy6KvnlthE+oEFgBw6DQq6IXeU0wfHTQbC0FKEZcTN2upS8CTQvHpopPTZTbjq
 JzjeRbhCHZ+NjlZouIOe8OqpAyhz/44I2O2PVxhMNrxtvz4tg3CFqiMr6XYj7JeJid+R
 5f+BiSMRQqRyCgB/tjoTKLu6CXhK8gOBJ6AOEHx8MoU8JPG5bRX/KLj9V0DZdDC/2JJQ
 HewK2ZeTiO/EtYj9jRekzdZCVdjAzM9kImXMNUNUolAr7cuiKAZvDEIdGq3DyLPzzO3M AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw0tx8ctd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:34:05 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2469XE3c013855;
        Fri, 6 May 2022 09:34:05 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw0tx8cst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:34:05 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2469Wj5h018759;
        Fri, 6 May 2022 09:34:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3fscdk64n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:34:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2469Xx2C46268864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 09:34:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D78E75204E;
        Fri,  6 May 2022 09:33:59 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.85.201])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0D53E5204F;
        Fri,  6 May 2022 09:33:55 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2 1/2] tools/perf: Add utility function to read
 /proc/cpuinfo for any field
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <YnQIYdqh9VsKm2aX@kernel.org>
Date:   Fri, 6 May 2022 15:03:51 +0530
Cc:     Ian Rogers <irogers@google.com>, maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        kajoljain <kjain@linux.ibm.com>, disgoel@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <460BE4F4-9748-40E4-94F3-B4263FD34D5F@linux.vnet.ibm.com>
References: <20220505094000.58220-1-atrajeev@linux.vnet.ibm.com>
 <20220505094000.58220-2-atrajeev@linux.vnet.ibm.com>
 <YnQIYdqh9VsKm2aX@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cN-Gk7LU2NkQ2-LNRs_a65Qp84_p5nL7
X-Proofpoint-GUID: cvKnwltpUEDfRP0Mdo1hiPHpoUt_4Sxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_03,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 05-May-2022, at 10:54 PM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> Em Thu, May 05, 2022 at 03:09:59PM +0530, Athira Rajeev escreveu:
>> /proc/cpuinfo provides information about type of processor, number
>> of CPU's etc. Reading /proc/cpuinfo file outputs useful information
>> by field name like cpu, platform, model (depending on architecture)
>> and its value separated by colon.
>>=20
>> Add new utility function "cpuinfo_field" in "util/header.c" which
>> accepts field name as input string to search in /proc/cpuinfo =
content.
>> This returns the first matching value as resulting string. Example,
>> calling the function "cpuinfo_field(platform)" in powerpc returns
>> the platform value. This can be used to fetch processor information
>> from "cpuinfo" by other utilities/testcases.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/util/header.c | 53 =
++++++++++++++++++++++++++++++++++++++++
>> tools/perf/util/header.h |  1 +
>> 2 files changed, 54 insertions(+)
>>=20
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index a27132e5a5ef..f08857f96606 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -983,6 +983,59 @@ static int write_dir_format(struct feat_fd *ff,
>> 	return do_write(ff, &data->dir.version, =
sizeof(data->dir.version));
>> }
>>=20
>> +/*
>> + * Return entry from /proc/cpuinfo
>> + * indicated by "search" parameter.
>> + */
>> +char *cpuinfo_field(const char *search)
>> +{
>> +	FILE *file;
>> +	char *buf =3D NULL;
>> +	char *copy_buf =3D NULL, *p;
>> +	size_t len =3D 0;
>> +
>> +	if (!search)
>> +		return NULL;
>> +
>> +	file =3D fopen("/proc/cpuinfo", "r");
>> +	if (!file)
>> +		return NULL;
>> +
>> +	while (getline(&buf, &len, file) > 0) {
>> +		if (!strncmp(buf, search, strlen(search)))
>=20
> Can you save the search string lenght in a variable and use it instead
> of calling strlen() for the same buffer for each line in =
/proc/cpuinfo?


Hi Arnaldo, Michael

Thanks for review comments. Based on suggestion from Michael, I am =
reworking on patch 2 to SKIP the test
if physical_id is set to -1 irrespective of value from cpuinfo.

In this patch, I had written "cpuinfo_field " function as generic =
function for retrieving any entry from /proc/cpuinfo.
But it won't be used in patch 2 now. Do you think this function is =
useful to keep ? Otherwise, I will drop patch 1

Thanks
Athira Rajeev

>=20
>> +			break;
>> +	}
>> +
>> +	if (feof(file))
>> +		goto done;
>> +
>> +	/*
>> +	 * Trim the new line and separate
>> +	 * value for search field from ":"
>> +	 * in cpuinfo line output.
>> +	 * Example output line:
>> +	 * platform : <value>
>> +	 */
>> +	copy_buf =3D buf;
>> +	p =3D strchr(copy_buf, ':');
>=20
> So you assume that this will always be there, right? Shouldn't we not
> assume that and check if p is NULL and bail out instead?
>=20
>> +
>> +	/* Go to string after ":" */
>> +	copy_buf =3D p + 1;
>> +	p =3D strchr(copy_buf, '\n');
>=20
> Ditto.
>=20
>> +	if (p)
>> +		*p =3D '\0';
>> +
>> +	/* Copy the filtered string after removing space to buf */
>> +	strcpy(buf, strim(copy_buf));
>> +
>> +	fclose(file);
>> +	return buf;
>> +
>> +done:
>=20
> Please rename this goto label to "not_found", "done" isn't intention
> revealing.
>=20
>> +	free(buf);
>> +	fclose(file);
>> +	return NULL;
>> +}
>> /*
>>  * Check whether a CPU is online
>>  *
>> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
>> index 0eb4bc29a5a4..b0f754364bd4 100644
>> --- a/tools/perf/util/header.h
>> +++ b/tools/perf/util/header.h
>> @@ -166,4 +166,5 @@ int get_cpuid(char *buffer, size_t sz);
>>=20
>> char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
>> int strcmp_cpuid_str(const char *s1, const char *s2);
>> +char *cpuinfo_field(const char *search);
>> #endif /* __PERF_HEADER_H */
>> --=20
>> 2.35.1
>=20
> --=20
>=20
> - Arnaldo

