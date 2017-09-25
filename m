From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf report: Fix debug messages with --call-graph
 option
Date: Mon, 25 Sep 2017 15:02:51 +0200
Message-ID: <20170925130251.GA20935@krava>
References: <1506154694-39691-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506154694-39691-1-git-send-email-zhangmengting@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mengting Zhang <zhangmengting@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, kjlx@templeofstupid.com, milian.wolff@kdab.com, wangnan0@huawei.com, huawei.libin@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Sat, Sep 23, 2017 at 04:18:14PM +0800, Mengting Zhang wrote:
> With --call-graph option, perf report can display call chains using
> type, min percent threshold, optional print limit and order. And the
> default call-graph parameter is 'graph,0.5,caller,function,percent'.
> 
> Before this patch, 'perf report --call-graph' shows incorrect debug
> messages as below:
> [root@localhost perf]# ./perf report --call-graph
> Invalid callchain mode: 0.5
> Invalid callchain order: 0.5
> Invalid callchain sort key: 0.5
> Invalid callchain config key: 0.5
> Invalid callchain mode: caller
> Invalid callchain mode: function
> Invalid callchain order: function
> Invalid callchain mode: percent
> Invalid callchain order: percent
> Invalid callchain sort key: percent
> 
> That is because in function __parse_callchain_report_opt(),each field
> of the call-graph parameter is passed to parse_callchain_{mode,order,
> sort_key,value} in turn until it meets the matching value.
> 
> For example, the order field "caller" is passed to parse_callchain_mode()
> firstly and obviously it doesn't match any mode field. Therefore
> parse_callchain_mode() will shows the debug message "Invalid callchain
> mode: caller", which could confuse users.
> 
> The patch fixes this issue by moving the warning out of the function
> parse_callchain_{mode,order,sort_key,value}.
> 
> Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
