From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] perf-probe: Improve warning message for buildid
 mismatch
Date: Wed, 3 Jan 2018 12:21:41 +0530
Message-ID: <305e3f8b-b669-af3c-98cb-1a4694149b6e@linux.vnet.ibm.com>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151358211494.25261.16134489192749792799.stgit@devbox>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org



On 12/18/2017 12:58 PM, Masami Hiramatsu wrote:
> Hello,
>
> This series ensure the build-ids for target binary and debuginfo
> are matched. If there is a mismatch, it warns user to check the
> package versions.

For the series,

Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
