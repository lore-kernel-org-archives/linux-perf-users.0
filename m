Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8D6FCF
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 08:03:34 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64099DA
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 01:03:33 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P7Zqqj002988;
	Mon, 25 Sep 2023 08:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oYZW7bO467/gec31GHRBzDNg711vancXLK2jnRRqlYs=;
 b=DGgkNh54S1F2DTlZzUDBrENDz3tSF1VAl+2cUJXuruECc8DcYH4X8kHrggIBN76jBO6s
 +2pBvgG82x9yidOBZpCgQT/O23ZkZ6qxjL6dfLXazUDdWoEH4SPxCrbQ0TqGkmVfDYAm
 gCoHunO+AJKRzoaByUPXRphkh6Qksi4MX5U5ncEgjZxPdR6maHtgIf7H/rlK+WypK90r
 74Xrp7WH5UlV0KztyzXznKIe3hO8luAI94Fr3P/rYRfoepdncoK5w3sHp0UHf5tpo2Wm
 jgpDl3v0+TqiiNj6NJj9oeGMlOMF4srWEqSO1OA34H/qFPLBiMzt2v2O4kwJqKi0wIB8 +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta6unmtnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 08:03:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38P7ZuMg003779;
	Mon, 25 Sep 2023 08:03:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ta6unmtnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 08:03:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38P7UuJW030409;
	Mon, 25 Sep 2023 08:03:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad2180sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 08:03:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38P83GoM26608360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Sep 2023 08:03:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680222004F;
	Mon, 25 Sep 2023 08:03:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0DF20043;
	Mon, 25 Sep 2023 08:03:13 +0000 (GMT)
Received: from [9.43.77.183] (unknown [9.43.77.183])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Sep 2023 08:03:13 +0000 (GMT)
Message-ID: <999336eb-8323-1718-12d1-ac61a200bc6e@linux.ibm.com>
Date: Mon, 25 Sep 2023 13:33:12 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized
 events
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YW5vyfc2ShnnvGxiNnZkgvPDg_-WGPk2
X-Proofpoint-GUID: _4mKYQpsoHH2hJnw-_IQ0IhQjY8oyIX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250057
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/7/23 22:29, Athira Rajeev wrote:
> Testcase "Parsing of all PMU events from sysfs" parse events for
> all PMUs, and not just cpu. In case of powerpc, the PowerVM
> environment supports events from hv_24x7 and hv_gpci PMU which
> is of example format like below:
> 
> - hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> - hv_gpci/event,partition_id=?/
> 
> The value for "?" needs to be filled in depending on system
> configuration. It is better to skip these parametrized events
> in this test as it is done in:
> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
> parametrized events")' which handled a simialr instance with
> "all PMU test".
> 
> Fix parse-events test to skip parametrized events since
> it needs proper setup of the parameters.

Patch looks good to me.

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
> v1 -> v2:
>  Addressed review comments from Ian. Updated size of
>  pmu event name variable and changed bool name which is
>  used to skip the test.
> 
>  tools/perf/tests/parse-events.c | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 658fb9599d95..1ecaeceb69f8 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2514,9 +2514,14 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>  	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>  		struct stat st;
>  		char path[PATH_MAX];
> +		char pmu_event[PATH_MAX];
> +		char *buf = NULL;
> +		FILE *file;
>  		struct dirent *ent;
> +		size_t len = 0;
>  		DIR *dir;
>  		int err;
> +		int n;
>  
>  		snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/events/",
>  			sysfs__mountpoint(), pmu->name);
> @@ -2538,11 +2543,44 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
>  			struct evlist_test e = { .name = NULL, };
>  			char name[2 * NAME_MAX + 1 + 12 + 3];
>  			int test_ret;
> +			bool is_event_parameterized = 0;
>  
>  			/* Names containing . are special and cannot be used directly */
>  			if (strchr(ent->d_name, '.'))
>  				continue;
>  
> +			/* exclude parametrized ones (name contains '?') */
> +			n = snprintf(pmu_event, sizeof(pmu_event), "%s%s", path, ent->d_name);
> +			if (n >= PATH_MAX) {
> +				pr_err("pmu event name crossed PATH_MAX(%d) size\n", PATH_MAX);
> +				continue;
> +			}
> +
> +			file = fopen(pmu_event, "r");
> +			if (!file) {
> +				pr_debug("can't open pmu event file for '%s'\n", ent->d_name);
> +				ret = combine_test_results(ret, TEST_FAIL);
> +				continue;
> +			}
> +
> +			if (getline(&buf, &len, file) < 0) {
> +				pr_debug(" pmu event: %s is a null event\n", ent->d_name);
> +				ret = combine_test_results(ret, TEST_FAIL);
> +				continue;
> +			}
> +
> +			if (strchr(buf, '?'))
> +				is_event_parameterized = 1;
> +
> +			free(buf);
> +			buf = NULL;
> +			fclose(file);
> +
> +			if (is_event_parameterized == 1) {
> +				pr_debug("skipping parametrized PMU event: %s which contains ?\n", pmu_event);
> +				continue;
> +			}
> +
>  			snprintf(name, sizeof(name), "%s/event=%s/u", pmu->name, ent->d_name);
>  
>  			e.name  = name;
