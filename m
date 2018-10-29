From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [PATCH] perf/stat: Handle different PMU names with common prefix
Date: Mon, 29 Oct 2018 08:50:59 -0400
Message-ID: <4cba8c1c-e1ec-1972-5d12-97804cf6aa14@gydle.com>
References: <20181023151616.78193-1-tmricht@linux.ibm.com>
 <7b3b23b7-1c73-66bf-611b-8dd9fb274694@gydle.com>
 <80512536-d668-489d-5f73-d7e4a4d54e2d@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80512536-d668-489d-5f73-d7e4a4d54e2d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kan.liang@linux.intel.com, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On 2018-10-29 8:18 a.m., Thomas-Mich Richter wrote:
> Yes, mistake on my side...
> but it is the same type of error , regardless if 6 or 7 characters are 
> compared:
> 
>       strncmp("cpmu_cf", "cpum_cf_diag", 7) 
> 
> returns 0 when it should not. The device names of both PMUs are different.
> 

OK, that works then.

You want to do a full-length comparison of PMU names, instead of comparing prefixes.

Reviewed-by: Sebastien Boisvert <sboisvert@gydle.com>
